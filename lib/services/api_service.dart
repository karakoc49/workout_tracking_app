import 'dart:convert';

import 'package:http/http.dart' as http;

import '/models/Exercise.dart';
import '/models/Workout.dart';
import '/models/WorkoutExercise.dart';
import '/utils/constants.dart';

class ApiService {
  Future<List<Exercise>?> getExercises() async {
    var client = http.Client();

    var uri = Uri.parse("$apiBaseUrl/exercise/");
    var response = await client.get(uri);
    print("response--> ${response.body}");
    if (response.statusCode == 200) {
      var decodedBody = utf8.decode(response.bodyBytes);
      return exerciseFromMap(decodedBody);
    }
  }

  Future<List<Exercise>?> getExercise(int id) async {
    var client = http.Client();

    var uri = Uri.parse("$apiBaseUrl/exercise/?id=$id");
    var response = await client.get(uri);
    print("response--> ${response.body}");
    if (response.statusCode == 200) {
      var decodedBody = utf8.decode(response.bodyBytes);
      return exerciseFromMap(decodedBody);
    }
  }

  Future<List<Workout>?> getWorkouts() async {
    var client = http.Client();

    var uri = Uri.parse("$apiBaseUrl/workout/");
    var response = await client.get(uri);
    print("response--> ${response.body}");
    if (response.statusCode == 200) {
      var decodedBody = utf8.decode(response.bodyBytes);
      return workoutFromMap(decodedBody);
    }
  }

  Future<List<Workout>?> getWorkout(int id) async {
    var client = http.Client();

    var uri = Uri.parse("$apiBaseUrl/workout/?id=$id");
    var response = await client.get(uri);
    print("response--> ${response.body}");
    if (response.statusCode == 200) {
      var decodedBody = utf8.decode(response.bodyBytes);
      return workoutFromMap(decodedBody);
    }
  }

  Future<List<WorkoutExercise>?> getWorkoutExercises() async {
    var client = http.Client();

    var uri = Uri.parse("$apiBaseUrl/workout-exercise/");
    var response = await client.get(uri);
    print("response--> ${response.body}");
    if (response.statusCode == 200) {
      var decodedBody = utf8.decode(response.bodyBytes);
      return workoutExerciseFromMap(decodedBody);
    }
  }

  Future<List<WorkoutExercise>?> getWorkoutExercise(int id) async {
    var client = http.Client();

    var uri = Uri.parse("$apiBaseUrl/workout-exercise/?exercise=$id");
    var response = await client.get(uri);
    print("response--> ${response.body}");
    if (response.statusCode == 200) {
      var decodedBody = utf8.decode(response.bodyBytes);
      return workoutExerciseFromMap(decodedBody);
    }
  }

  Future<List<WorkoutExercise>?> getWorkoutExerciseByWorkoutId(
      int workout_id) async {
    var client = http.Client();

    var uri = Uri.parse("$apiBaseUrl/workout-exercise/?workout_id=$workout_id");
    var response = await client.get(uri);
    print("response--> ${response.body}");
    if (response.statusCode == 200) {
      var decodedBody = utf8.decode(response.bodyBytes);
      return workoutExerciseFromMap(decodedBody);
    }
  }
}
