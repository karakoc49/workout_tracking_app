import 'package:flutter/material.dart';
import 'package:workout_tracking_app/models/WorkoutExercise.dart';
import 'package:workout_tracking_app/services/api_service.dart';

class EditWorkoutExerciseService {
  ApiService _apiService = ApiService();

  Future<void> showConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Discard changes?'),
          content:
              const Text('Do you want to discard your changes and go back?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Keep editing'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
              child: const Text('Discard'),
            ),
          ],
        );
      },
    );
  }

  Future<void> saveWorkoutExercise(
      WorkoutExercise workoutExercise, workoutExerciseId, context) async {
    var workoutExerciseData = <String, dynamic>{
      'workout': workoutExercise.workout,
      'exercise': workoutExercise.exercise,
      'sets': workoutExercise.sets,
      'reps': workoutExercise.reps,
      'weight': workoutExercise.weight,
    };

    await _apiService.putData(
        workoutExerciseData, 'workout-exercise', workoutExerciseId);

    Navigator.pop(context);
  }
}
