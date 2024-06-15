import 'dart:math';
import 'dart:ui';

import '../models/Workout.dart';
import '../models/WorkoutExercise.dart';
import 'api_service.dart';

class WorkoutDetailScreenService {
  ApiService apiService = ApiService();

  List<WorkoutExercise>? workoutExercises = [];
  List<Workout>? workout;
  List<Map<String, dynamic>> mergedData = [];
  var isLoaded = false;

  Future<void> getData(int workoutId) async {
    // Fetch workout exercises by workoutId
    workoutExercises =
        await apiService.getWorkoutExerciseByWorkoutId(workoutId);

    if (workoutExercises == null) {
      // Handle case where workoutExercises is null
      return;
    }

    // Iterate through each workout exercise
    for (var workoutExercise in workoutExercises!) {
      // Fetch exercise data using the exercise ID from workoutExercise
      var exercises = await apiService.getExercise(workoutExercise.exercise);

      // Assuming getExercise returns a list, we take the first element
      if (exercises != null && exercises.isNotEmpty) {
        var exercise = exercises.first;

        // Create a merged map
        var mergedItem = {
          'id': workoutExercise.id,
          'workout': workoutExercise.workout,
          'exercise': workoutExercise.exercise,
          'sets': workoutExercise.sets,
          'reps': workoutExercise.reps,
          'weight': workoutExercise.weight,
          'exercise_data': {
            'id': exercise.id,
            'name': exercise.name,
            'description': exercise.description,
            'muscle_group': exercise.muscleGroup,
            'gif_url': exercise.gifUrl,
          },
        };

        // Add merged item to the list
        mergedData.add(mergedItem);
      }
    }

    // Fetch workout details
    workout = await apiService.getWorkout(workoutId);

    if (workoutExercises != null) {
      isLoaded = true;
    }

    // Print the merged data for debugging
    for (var item in mergedData) {
      print(item);
    }
  }

  Future<bool> deleteWorkout(int workoutId) async {
    try {
      // Delete workout data
      await apiService.deleteData('workout', workoutId);
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
