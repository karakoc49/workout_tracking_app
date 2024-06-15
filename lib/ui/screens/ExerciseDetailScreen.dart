import 'package:flutter/material.dart';

class ExerciseDetailScreen extends StatefulWidget {
  final String name;
  final String description;
  final String muscleGroup;
  final String gifUrl;

  const ExerciseDetailScreen({
    Key? key,
    required this.name,
    required this.description,
    required this.muscleGroup,
    required this.gifUrl,
  }) : super(key: key);

  @override
  _ExerciseDetailScreenState createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.gifUrl),
            SizedBox(height: 16.0),
            Text(
              widget.name,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              widget.muscleGroup,
              style: TextStyle(fontSize: 18.0, color: Colors.grey[600]),
            ),
            SizedBox(height: 16.0),
            Text(
              widget.description,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
