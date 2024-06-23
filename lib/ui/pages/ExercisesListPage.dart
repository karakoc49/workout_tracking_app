import 'package:flutter/material.dart';
import 'package:workout_tracking_app/ui/widgets/AppBar.dart';
import 'package:workout_tracking_app/utils/responsive_padding.dart';

import '../../services/exercise_list_page_service.dart';
import '../screens/WorkoutSelectionScreen.dart';
import '../widgets/ExerciseListTile.dart';
import '/models/Exercise.dart';

class ExerciseListPage extends StatefulWidget {
  const ExerciseListPage({super.key});

  @override
  State<ExerciseListPage> createState() => _ExerciseListPageState();
}

class _ExerciseListPageState extends State<ExerciseListPage> {
  final TextEditingController _searchController = TextEditingController();
  ExerciseListPageService exerciseListPageService = ExerciseListPageService();
  var isLoaded = false;
  List<Exercise>? exercises;
  List<Exercise> filteredExercises = [];
  List<Exercise> selectedExercises = [];

  @override
  void initState() {
    super.initState();
    exerciseListPageService.getData().then((value) {
      setState(() {
        exercises = value;
        filteredExercises = value; // Initially show all exercises
        isLoaded = true;
      });
    });
    _searchController.addListener(_filterExercises);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterExercises);
    _searchController.dispose();
    super.dispose();
  }

  void _filterExercises() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredExercises = exercises!
          .where((exercise) =>
              exercise.name.toLowerCase().contains(query) ||
              exercise.description.toLowerCase().contains(query) ||
              exercise.muscleGroup.toLowerCase().contains(query))
          .toList();
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
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                    },
                  ),
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
                  itemCount: filteredExercises.length,
                  itemBuilder: (context, index) {
                    final exercise = filteredExercises[index];
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
