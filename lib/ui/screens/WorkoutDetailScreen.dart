import 'package:flutter/material.dart';
import 'package:workout_tracking_app/services/workout_detail_screen_service.dart';
import 'package:workout_tracking_app/ui/widgets/AppBar.dart';

class WorkoutDetailScreen extends StatefulWidget {
  final int workoutId;
  const WorkoutDetailScreen({super.key, required this.workoutId});

  @override
  State<WorkoutDetailScreen> createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  WorkoutDetailScreenService workoutDetailScreenService =
      WorkoutDetailScreenService();

  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    workoutDetailScreenService.getData(widget.workoutId).then((value) {
      setState(() {
        isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Visibility(
          visible: isLoaded,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: SingleChildScrollView(
            // Allow scrolling for long workout details
            child: Column(
              children: [
                Text(isLoaded
                    ? workoutDetailScreenService.workout?.first.name ??
                        'Workout Name'
                    : 'Workout Name'),
                Text('Exercises:'),
                ListView.builder(
                  shrinkWrap: true, // Prevent list from expanding unnecessarily
                  physics:
                      NeverScrollableScrollPhysics(), // Disable scrolling for exercise list
                  itemCount: workoutDetailScreenService.exercises!.length,
                  itemBuilder: (context, index) {
                    final exercise =
                        workoutDetailScreenService.exercises![index];
                    return Column(
                      children: [
                        Text(exercise.name),
                        Text(exercise.description),
                        Text(exercise.muscleGroup),
                        Text(exercise.muscleGroup),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
