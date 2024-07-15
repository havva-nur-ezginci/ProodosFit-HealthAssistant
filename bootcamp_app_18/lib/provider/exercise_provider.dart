import 'package:bootcamp_app_18/models/exercise_model.dart';
import 'package:bootcamp_app_18/service/exercise_resource_service.dart';
import 'package:flutter/material.dart';

class ExerciseProvider extends ChangeNotifier {
  List<Exercise> _exercises = [];

  List<Exercise> get exercises => _exercises;

  // unique muscles
  final Set<String> _uniquePrimaryMuscles = {};
  Set<String> get uniquePrimaryMuscles => _uniquePrimaryMuscles;

  final ExerciseService _exerciseService = ExerciseService();

  Future<void> fetchExercises() async {
    try {
      _exercises = await _exerciseService.fetchExercises();

      exercises.forEach((exercise) {
        if (exercise.primaryMuscles != null &&
            exercise.primaryMuscles!.isNotEmpty) {
          _uniquePrimaryMuscles.addAll(exercise.primaryMuscles!);
        }
      });

      notifyListeners(); // // Notify listeners of changes
    } catch (e) {
      print('Egzersizler çekilemedi: $e');
    }
  }

  // Kategoriye göre egzersizleri filtreleme
  List<Exercise> getExercisesByCategory(String categoryName) {
    return _exercises
        .where((exercise) =>
            exercise.primaryMuscles?.contains(categoryName) ?? false)
        .toList();
  }

  // ID'ye göre tek bir egzersizi al
  Exercise? getExerciseById(String id) {
    return _exercises.firstWhere((exercise) => exercise.id == id);
  }
}