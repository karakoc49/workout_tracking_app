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
    for (var workoutExercise in workoutExercises!) {
      List<Exercise>? _exercise =
          await ApiService().getExercise(workoutExercise.exercise);
      if (_exercise?.isEmpty ?? true) {
        return null;
      } else {
        exercises!.add(_exercise![0]);
      }
    }
    workout = await ApiService().getWorkout(workoutId);

    if (workoutExercises != null) {
      isLoaded = true;
    }
  }
}
