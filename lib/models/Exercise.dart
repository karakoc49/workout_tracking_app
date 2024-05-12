// To parse this JSON data, do
//
//     final exercise = exerciseFromMap(jsonString);

import 'dart:convert';

List<Exercise> exerciseFromMap(String str) =>
    List<Exercise>.from(json.decode(str).map((x) => Exercise.fromMap(x)));

String exerciseToMap(List<Exercise> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Exercise {
  int id;
  String name;
  String description;
  String muscleGroup;
  String gifUrl;

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.muscleGroup,
    required this.gifUrl,
  });

  factory Exercise.fromMap(Map<String, dynamic> json) => Exercise(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        muscleGroup: json["muscle_group"],
        gifUrl: json["gif_url"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "muscle_group": muscleGroup,
        "gif_url": gifUrl,
      };

  @override
  String toString() {
    return 'Exercise{id: $id, name: $name, description: $description, muscleGroup: $muscleGroup, gifUrl: $gifUrl}';
  }
}
