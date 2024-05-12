// To parse this JSON data, do
//
//     final workoutExercise = workoutExerciseFromMap(jsonString);

import 'dart:convert';

import 'Exercise.dart';

List<WorkoutExercise> workoutExerciseFromMap(String str) =>
    List<WorkoutExercise>.from(
        json.decode(str).map((x) => WorkoutExercise.fromMap(x)));

String workoutExerciseToMap(List<WorkoutExercise> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class WorkoutExercise {
  int id;
  int workout;
  int sets;
  int reps;
  int weight;
  Exercise exerciseData;

  WorkoutExercise({
    required this.id,
    required this.workout,
    required this.sets,
    required this.reps,
    required this.weight,
    required this.exerciseData,
  });

  factory WorkoutExercise.fromMap(Map<String, dynamic> json) => WorkoutExercise(
        id: json["id"],
        workout: json["workout"],
        sets: json["sets"],
        reps: json["reps"],
        weight: json["weight"],
        exerciseData: Exercise.fromMap(json["exercise_data"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "workout": workout,
        "sets": sets,
        "reps": reps,
        "weight": weight,
        "exercise_data": exerciseData.toMap(),
      };
}
