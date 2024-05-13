import '../models/Workout.dart';
import 'api_service.dart';

class HomePageService {
  final ApiService apiService = ApiService();
  List<Workout>? workouts;
  bool isLoaded = false;

  Future<List<Workout>> getData() async {
    try {
      workouts = await apiService.getWorkouts();
      isLoaded = true;
      return workouts ?? [];
    } catch (e) {
      isLoaded = false;
      // Handle error or throw it to be caught by the caller
      throw e;
    }
  }
}
