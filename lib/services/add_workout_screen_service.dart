import 'package:workout_tracking_app/services/api_service.dart';

import '../models/Workout.dart';

class AddWorkoutScreenService {
  ApiService _apiService = ApiService();

  Future<Workout> postWorkoutToApi(Workout workout) async {
    var workoutData = <String, dynamic>{
      'name': workout.name,
      'description': workout.description,
      'user': workout.user,
      'workout_image_url': workout.workoutImageUrl,
    };

    // Send POST request to the API to create the workout
    Map<String, dynamic> responseData =
        await _apiService.postData(workoutData, 'workout');

    // Parse the response data to create a Workout object with the ID
    Workout createdWorkout = Workout.fromMap(responseData);

    return createdWorkout;
  }
}
