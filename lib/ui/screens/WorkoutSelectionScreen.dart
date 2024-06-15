import 'package:flutter/material.dart';

import '../../models/Exercise.dart';
import '../../models/Workout.dart';
import '../../services/exercise_list_page_service.dart';
import '../../services/home_page_service.dart';

class WorkoutSelectionScreen extends StatefulWidget {
  final List<Exercise> selectedExercises;

  const WorkoutSelectionScreen({Key? key, required this.selectedExercises})
      : super(key: key);

  @override
  State<WorkoutSelectionScreen> createState() => _WorkoutSelectionScreenState();
}

class _WorkoutSelectionScreenState extends State<WorkoutSelectionScreen> {
  final HomePageService homePageService = HomePageService();
  ExerciseListPageService exerciseListPageService = ExerciseListPageService();
  var isLoaded = false;
  List<Workout>? workouts;

  @override
  void initState() {
    super.initState();
    homePageService.getData().then((value) {
      setState(() {
        workouts = value;
        isLoaded = true;
      });
    });
  }

  void selectWorkout(int workoutId) async {
    await exerciseListPageService.sendSelectedExercises(
        widget.selectedExercises, workoutId);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Exercises have been added to the workout!")),
    );
    Navigator.pop(context); // Go back to the previous screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select a Workout")),
      body: isLoaded
          ? ListView.builder(
              itemCount: workouts?.length ?? 0,
              itemBuilder: (context, index) {
                final workout = workouts![index];
                return Card(
                  elevation: 2.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  child: ListTile(
                    onTap: () => selectWorkout(workout.id),
                    contentPadding: const EdgeInsets.all(10.0),
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: workout.workoutImageUrl != ''
                          ? Image.network(
                              workout.workoutImageUrl,
                              fit: BoxFit.cover,
                              width: 50,
                              height: 50,
                            )
                          : Text(workout.name[0].toUpperCase(),
                              style: TextStyle(color: Colors.white)),
                    ),
                    title: Text(workout.name,
                        style: Theme.of(context).textTheme.titleLarge),
                    subtitle: Text(
                      workout.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    trailing: Icon(Icons.chevron_right,
                        color: Theme.of(context).primaryColor),
                  ),
                );
              },
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
