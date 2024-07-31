import 'package:bootcamp_app_18/models/new_user_model.dart';
import 'package:bootcamp_app_18/provider/app_provider.dart';
import 'package:bootcamp_app_18/service/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  StatisticsPageState createState() => StatisticsPageState();
}

class StatisticsPageState extends State<StatisticsPage> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  late AppProvider appProvider;
  NewUser? activeUser;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appProvider = Provider.of<AppProvider>(context);
    String email = appProvider.activeUserEmail ?? "";
    getActiveUserInfo(email);
  }

  Future<void> getActiveUserInfo(String email) async {
    activeUser = await SharedPrefService.getUserInfo(email);
    if (activeUser != null) {
      if (activeUser!.height != null) {
        _heightController.text = activeUser!.height!;
      }
      if (activeUser!.weight != null) {
        _weightController.text = activeUser!.weight!;
      }
      if (activeUser!.age != null) {
        _ageController.text = activeUser!.age!;
      }
    }
  }

  double _bmi = 0;
  double _calorieNeeds = 0;
  double _bmr = 0;
  String _bmiCategory = "";

  void _calculateStats() {
    final double height = double.tryParse(_heightController.text) ?? 0;
    final double weight = double.tryParse(_weightController.text) ?? 0;
    final int age = int.tryParse(_ageController.text) ?? 0;

    if (height > 0 && weight > 0 && age > 0) {
      setState(() {
        _bmi = weight / ((height / 100) * (height / 100));
        _bmr = 10 * weight + 6.25 * height - 5 * age + 5; // Erkekler için
        _calorieNeeds =
            _bmr * 1.2; // Hafif aktif (hareketsiz) aktivite seviyesi

        _bmiCategory = _getBmiCategory(_bmi);
      });
    }
  }

  String _getBmiCategory(double bmi) {
    if (bmi < 18.5) {
      return "Zayıf";
    } else if (bmi < 24.9) {
      return "Normal kilolu";
    } else if (bmi < 29.9) {
      return "Fazla kilolu";
    } else if (bmi < 34.9) {
      return "1. Derece obez";
    } else if (bmi < 39.9) {
      return "2. Derece obez";
    } else {
      return "3. Derece obez (Morbid obez)";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('İstatistikler'),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: _heightController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Boy (cm)',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.height),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _weightController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Kilo (kg)',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.monitor_weight),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _ageController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Yaş',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.cake),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _calculateStats,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                          ),
                          child: const Text(
                            'Hesapla',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.fitness_center,
                                size: 40, color: Colors.blue),
                            const SizedBox(width: 10),
                            Text(
                              'Vücut Kitle Endeksi: ${_bmi.toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.assessment,
                                size: 40, color: Colors.green),
                            const SizedBox(width: 10),
                            Text(
                              'Durum: $_bmiCategory',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.local_fire_department,
                                size: 40, color: Colors.red),
                            const SizedBox(width: 10),
                            Text(
                              'Kalori İhtiyacı: ${_calorieNeeds.toStringAsFixed(2)} kcal',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.flash_on,
                                size: 40, color: Colors.orange),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Bazal Metabolizma: ${_bmr.toStringAsFixed(2)} kcal',
                                style: const TextStyle(fontSize: 18),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
