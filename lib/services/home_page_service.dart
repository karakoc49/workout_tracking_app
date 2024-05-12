import '../models/Workout.dart';
import 'api_service.dart';

class HomePageService {
  final ApiService apiService = ApiService();
  List<Workout>? workouts;
  bool isLoaded = false;

  Future<void> getData() async {
    try {
      workouts = await apiService.getWorkouts();
      if (workouts != null) {
        isLoaded = true;
      }
    } catch (e) {
      if (workouts != null) {
        isLoaded = false;
      }
      // Consider handling errors and showing an appropriate message or UI
    }
  }
}
