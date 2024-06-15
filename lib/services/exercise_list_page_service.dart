import '../models/Exercise.dart';
import '../utils/constants.dart';
import 'api_service.dart';

class ExerciseListPageService {
  final ApiService _apiService = ApiService();
  List<Exercise>? exercises;
  bool isLoaded = false;

  Future<List<Exercise>> getData() async {
    try {
      exercises = await _apiService.getExercises();
      isLoaded = true;
      return exercises ?? [];
    } catch (e) {
      isLoaded = false;
      // Handle error or throw it to be caught by the caller
      throw e;
    }
  }

  Future<void> sendSelectedExercises(
      List<Exercise> selectedExercises, int workoutId) async {
    List<Map<String, dynamic>> formattedWorkoutExercises =
        selectedExercises.map((exercise) {
      return {
        'workout': workoutId,
        'exercise': exercise.id,
        'sets': defaultSetNumber, // Default value
        'reps': defaultRepNumber, // Default value
        'weight': defaultWeight, // Default value
      };
    }).toList();

    for (var workoutExercise in formattedWorkoutExercises) {
      print("Sending exercise: $workoutExercise");
      await _apiService.postData(workoutExercise, 'workout-exercise');
    }
  }
}
