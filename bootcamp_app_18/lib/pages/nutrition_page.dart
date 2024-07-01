import 'package:flutter/material.dart';

class NutritionPage extends StatelessWidget {
  const NutritionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beslenme'),
      ),
      body: const Center(
        child: Text(
          'Bu sayfa henüz yapılandırılmadı.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
