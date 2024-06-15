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
    return null;
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
    return null;
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
    return null;
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
    return null;
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
    return null;
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
    return null;
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
    return null;
  }

  Future<Map<String, dynamic>> postData(
      Map<String, dynamic> data, String urlTail) async {
    var headers = <String, String>{
      'Content-Type': 'application/json',
    };

    var uri = Uri.parse('$apiBaseUrl/$urlTail/');
    var response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      print('Data posted successfully!');

      // Extract and return the response data (including the ID)
      Map<String, dynamic> responseData = jsonDecode(response.body);
      return responseData;
    } else {
      print('Failed to post data: ${response.statusCode}');
      throw Exception('Failed to post data: ${response.statusCode}');
    }
  }

  Future<void> putData(
      Map<String, dynamic> data, String urlTail, int id) async {
    var headers = <String, String>{
      'Content-Type': 'application/json',
    };

    var uri = Uri.parse('$apiBaseUrl/$urlTail/?id=$id');
    var response = await http.put(
      uri,
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('Data updated successfully!');
    } else {
      print('Failed to update data: ${response.statusCode}');
    }
  }

  Future<void> deleteData(String urlTail, int id) async {
    var headers = <String, String>{
      'Content-Type': 'application/json',
    };

    var uri = Uri.parse('$apiBaseUrl/$urlTail/?id=$id');
    var response = await http.delete(
      uri,
      headers: headers,
    );

    if (response.statusCode == 204) {
      print('Data deleted successfully!');
    } else {
      print('Failed to delete data: ${response.statusCode}');
    }
  }
}
