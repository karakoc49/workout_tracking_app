// To parse this JSON data, do
//
//     final workoutExercise = workoutExerciseFromMap(jsonString);

import 'dart:convert';

List<WorkoutExercise> workoutExerciseFromMap(String str) =>
    List<WorkoutExercise>.from(
        json.decode(str).map((x) => WorkoutExercise.fromMap(x)));

String workoutExerciseToMap(List<WorkoutExercise> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class WorkoutExercise {
  int id;
  int workout;
  int exercise;
  int sets;
  int reps;

  WorkoutExercise({
    required this.id,
    required this.workout,
    required this.exercise,
    required this.sets,
    required this.reps,
  });

  factory WorkoutExercise.fromMap(Map<String, dynamic> json) => WorkoutExercise(
        id: json["id"],
        workout: json["workout"],
        exercise: json["exercise"],
        sets: json["sets"],
        reps: json["reps"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "workout": workout,
        "exercise": exercise,
        "sets": sets,
        "reps": reps,
      };
}
