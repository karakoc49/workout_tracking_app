import 'dart:math';
import 'dart:ui';

import '../models/Exercise.dart';
import '../models/Workout.dart';
import '../models/WorkoutExercise.dart';
import 'api_service.dart';

class WorkoutDetailScreenService {
  ApiService apiService = ApiService();

  List<WorkoutExercise>? workoutExercises = [];
  List<Workout>? workout = [];
  List<Exercise>? exercises = [];
  var isLoaded = false;

  getData(workoutId) async {
    workoutExercises =
        await ApiService().getWorkoutExerciseByWorkoutId(workoutId);

    if (workoutExercises == null) {
      // Handle case where workoutExercises is null
      return null;
    }

    for (var workoutExercise in workoutExercises!) {
      // Assuming workoutExercise includes necessary exercise data
      var exercise = workoutExercise.exerciseData;

      // You can directly use the exercise data from workoutExercise
      print("Exercise Name: ${exercise.name}");
      print("Exercise Description: ${exercise.description}");
      print("Exercise Image URL: ${exercise.gifUrl}");

      // You can access other fields of workoutExercise as well
      print("Sets: ${workoutExercise.sets}");
      print("Reps: ${workoutExercise.reps}");
      print("Weight: ${workoutExercise.weight}");

      // Add exercise to the exercises list if needed
      exercises!.add(exercise);
    }

    workout = await ApiService().getWorkout(workoutId);

    if (workoutExercises != null) {
      isLoaded = true;
    }
  }

  Future<bool> deleteWorkout(int workoutId) async {
    try {
      // Delete workout data
      await ApiService().deleteData('workout', workoutId);
      return true; // Return true if deletion is successful
    } catch (e) {
      print('Error deleting data: $e');
      return false; // Return false if there is an error
    }
  }

  final Random _random = Random();

  Future<Color> generateRandomColor() async {
    return Color.fromARGB(
      255,
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
    );
  }
}
