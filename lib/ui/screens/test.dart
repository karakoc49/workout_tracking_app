import 'package:flutter/material.dart';

import '/models/Exercise.dart';
import '/services/api_service.dart';

class ExerciseListTest extends StatefulWidget {
  const ExerciseListTest({super.key});

  @override
  State<ExerciseListTest> createState() => _ExerciseListTestState();
}

class _ExerciseListTestState extends State<ExerciseListTest> {
  List<Exercise>? exercises;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    exercises = await ApiService().getExercises();
    if (exercises != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemCount: exercises?.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Column(
                    children: [
                      Text(exercises![index].name!,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Image(image: NetworkImage(exercises![index].gifUrl!)),
                      Text(
                        exercises![index].description!,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        exercises![index].muscleGroup!,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50),
              ],
            );
          },
        ),
        replacement: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
