import 'package:flutter/material.dart';
import 'package:workout_tracking_app/ui/widgets/AppBar.dart';
import 'package:workout_tracking_app/utils/responsive_padding.dart';

import '../../services/exercise_list_page_service.dart';
import '../screens/WorkoutSelectionScreen.dart';
import '../widgets/ExerciseListTile.dart';
import '/models/Exercise.dart';

final TextEditingController _searchController = TextEditingController();

class ExerciseListPage extends StatefulWidget {
  const ExerciseListPage({super.key});

  @override
  State<ExerciseListPage> createState() => _ExerciseListPageState();
}

class _ExerciseListPageState extends State<ExerciseListPage> {
  ExerciseListPageService exerciseListPageService = ExerciseListPageService();
  var isLoaded = false;
  List<Exercise>? exercises;
  List<Exercise> selectedExercises = [];

  @override
  void initState() {
    super.initState();
    exerciseListPageService.getData().then((value) {
      setState(() {
        exercises = value;
        isLoaded = true;
      });
    });
  }

  void selectWorkout() {
    if (selectedExercises.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WorkoutSelectionScreen(
            selectedExercises: selectedExercises,
          ),
        ),
      );
    }
  }

  void onSelectExercise(Exercise exercise, bool isSelected) {
    if (isSelected) {
      setState(() {
        selectedExercises.add(exercise);
      });
    } else {
      setState(() {
        selectedExercises.remove(exercise);
      });
    }
    print("Selected exercises: $selectedExercises");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBarWidget(backgroundColor: Colors.lightBlue[50]!),
      body: ResponsivePadding(
        padding: 14.0,
        child: Column(
          children: [
            const Text(
              'Exercises',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
            SizedBox(
              height: 15,
            ),
            Visibility(
              visible: isLoaded,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: Expanded(
                child: ListView.builder(
                  itemCount: exercises?.length,
                  // shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final exercise = exercises![index];
                    return ExerciseListTile(
                      name: exercise.name,
                      description: exercise.description,
                      muscleGroup: exercise.muscleGroup,
                      gifUrl: exercise.gifUrl,
                      onSelect: (isSelected) =>
                          onSelectExercise(exercise, isSelected),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: selectedExercises.isNotEmpty
          ? FloatingActionButton(
              onPressed: selectWorkout,
              child: Icon(Icons.send),
            )
          : null,
    );
  }
}
