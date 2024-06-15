import 'package:flutter/material.dart';
import 'package:workout_tracking_app/services/api_service.dart';

import '../models/Workout.dart';

class EditWorkoutScreenService {
  final ApiService _apiService = ApiService();

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

  Future<void> saveWorkout(Workout workout, workoutId, context) async {
    var workoutData = <String, dynamic>{
      'name': workout.name,
      'description': workout.description,
      'user': workout.user,
      'workout_image_url': workout.workoutImageUrl,
    };

    await _apiService.putData(workoutData, 'workout', workoutId);

    Navigator.pop(context);
  }
}
