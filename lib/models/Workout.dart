// To parse this JSON data, do
//
//     final workout = workoutFromMap(jsonString);

import 'dart:convert';

List<Workout> workoutFromMap(String str) =>
    List<Workout>.from(json.decode(str).map((x) => Workout.fromMap(x)));

String workoutToMap(List<Workout> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Workout {
  int id;
  String name;
  String description;
  int user;

  Workout({
    required this.id,
    required this.name,
    required this.description,
    required this.user,
  });

  factory Workout.fromMap(Map<String, dynamic> json) => Workout(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        user: json["user"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "user": user,
      };
}
