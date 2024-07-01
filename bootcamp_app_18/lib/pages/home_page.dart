import 'dart:core';
import 'package:bootcamp_app_18/constants/color.dart';
import 'package:bootcamp_app_18/constants/motivational_quotes.dart';
import 'package:bootcamp_app_18/pages/exercise_categories_page.dart';
import 'package:bootcamp_app_18/pages/notifications_page.dart';
import 'package:bootcamp_app_18/pages/nutrition_page.dart';
import 'package:bootcamp_app_18/pages/profil_page.dart';
import 'package:bootcamp_app_18/pages/programs_page.dart';
import 'package:bootcamp_app_18/pages/statistics_page.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double appBarHeight = 50;
  double motivationCardHeight = 250;
  late double aspectRatio; //grid height

  int _currentIndex = 0;

  final int _quotesLength = MotivationalQuotes.quotes.length;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //initState den sonra builden önce çalışır
    super.didChangeDependencies();
    calculateAspectRatio();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar - profil - bildirim - söz
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appBarHeight),
        child: AppBar(
          title: const Text(
            'Enerjinizi yükseltin,\nsağlığınızı koruyun!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
          ),
          actions: [
            //bildirimler
            IconButton(
              icon: const Icon(Icons.notifications, size: 30),
              onPressed: () {
                // Bildirim sayfasına yönlendirme
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationsPage()));
              },
            ),
            //Profil
            IconButton(
              icon: const Icon(Icons.person, size: 30),
              onPressed: () {
                // Profil sayfasına yönlendirme
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilPage()));
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Motivasyon resim ve sözleri
            GestureDetector(
              onTap: _nextQuote,
              child: Container(
                height: motivationCardHeight,
                width: double.infinity,
                //resim
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        MotivationalQuotes.quotes[_currentIndex]['image']!),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                //motivasyon sözleri
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      MotivationalQuotes.quotes[_currentIndex]['quote']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.black26,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            //grid bölümü ezgersiz-diyet-hesaplama
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //motivasyon cümlesi noktaları
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildDotIndicator(),
                  ),
                  const SizedBox(height: 10),
                  // Gridview Section
                  Expanded(
                    child: GridView.count(
                      shrinkWrap: true, //scroll
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: aspectRatio,
                      children: [
                        _buildGridTile(
                            'Egzersizler', Icons.fitness_center, context),
                        _buildGridTile('Beslenme', Icons.restaurant, context),
                        _buildGridTile(
                            'Programlar', Icons.calendar_today, context),
                        _buildGridTile(
                            'İstatistikler', Icons.show_chart, context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

// Sonraki motivasyon alıntısına geçmek için mevcut alıntı günceller
  void _nextQuote() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _quotesLength;
    });
  }

// Her bir motivasyon alıntısı için bir daire göstergesi oluşturur
  List<Widget> _buildDotIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < _quotesLength; i++) {
      indicators.add(Container(
        width: 8,
        height: 8,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentIndex == i ? Colors.blue : Colors.grey,
        ),
      ));
    }
    return indicators;
  }

//grid -alt bölümdeki öğeyi oluşturma metodu
  Widget _buildGridTile(String title, IconData icon, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // İlgili sayfaya yönlendirme
        if (title == 'Egzersizler') {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ExerciseCategoriesPage()),
          );
        } else if (title == 'Beslenme') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NutritionPage()),
          );
        } else if (title == 'Programlar') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProgramsPage()),
          );
        } else if (title == 'İstatistikler') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const StatisticsPage()),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: HexColor(cardBackgroundColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.black),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(color: Colors.black, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

//grid bölümdeki öğelerrin boyutunu hesaplama - ekrana sığması hedeflenmiştir.
  void calculateAspectRatio() {
    double availableHeight = MediaQuery.of(context).size.height -
        appBarHeight -
        motivationCardHeight -
        60; // 60 is for padding and spacing

    aspectRatio =
        (MediaQuery.of(context).size.width / 2) / (availableHeight / 2);

    // ChildAspectRatio 0'dan küçük veya 0 ise 1 olarak ayarlanır
    if (aspectRatio <= 0) {
      aspectRatio = 1;
    }
  }
}
