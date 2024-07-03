import 'package:flutter/material.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('İstatistikler'),
      ),
      body: const Center(
        child: BMIWidget(),
      ),
    );
  }
}

class BMIWidget extends StatefulWidget {
  const BMIWidget({Key? key}) : super(key: key);

  @override
  _BMIWidgetState createState() => _BMIWidgetState();
}

class _BMIWidgetState extends State<BMIWidget> {
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  double? _bmiResult;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _heightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Boy (metre cinsinden)',
            ),
          ),
          SizedBox(height: 20.0),
          TextField(
            controller: _weightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Kilo (kg cinsinden)',
            ),
          ),
          SizedBox(height: 20.0),
          TextButton.icon(
            onPressed: () {
              _calculateBMI();
            },
            icon: Icon(Icons.calculate, color: Colors.white),
            label: const Text('BMI Hesapla', style: TextStyle(color: Colors.white)),
            style: TextButton.styleFrom(
              backgroundColor: Colors.blueGrey,
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          _bmiResult != null
              ? Text(
            'BMI: ${_bmiResult!.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 20.0),
          )
              : Container(),
        ],
      ),
    );
  }

  void _calculateBMI() {
    double height = double.parse(_heightController.text);
    double weight = double.parse(_weightController.text);
    double heightSquared = height * height;
    double bmi = weight / heightSquared;
    setState(() {
      _bmiResult = bmi;
    });
  }
}
