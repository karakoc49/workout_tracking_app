import 'package:workout_tracking_app/services/api_service.dart';

import '../models/Workout.dart';

class TestService {
  final ApiService _apiService = ApiService();

  Future<void> postWorkoutToApi(Workout workout) async {
    var workoutData = <String, dynamic>{
      'id': workout.id,
      'name': workout.name,
      'description': workout.description,
      'user': workout.user,
      'workout_image_url': workout.workoutImageUrl,
    };

    await _apiService.postData(workoutData, 'workout');
  }

  Future<void> putWorkoutToApi(Workout workout, workoutId) async {
    var workoutData = <String, dynamic>{
      'name': workout.name,
      'description': workout.description,
      'user': workout.user,
      'workout_image_url': workout.workoutImageUrl,
    };

    await _apiService.putData(workoutData, 'workout', workoutId);
  }
}
