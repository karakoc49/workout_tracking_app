import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:workout_tracking_app/services/workout_detail_screen_service.dart';
import 'package:workout_tracking_app/ui/widgets/AppBar.dart';
import 'package:workout_tracking_app/ui/widgets/WorkoutExerciseListTile.dart';

class WorkoutDetailScreen extends StatefulWidget {
  final int workoutId;
  const WorkoutDetailScreen({Key? key, required this.workoutId})
      : super(key: key);

  @override
  State<WorkoutDetailScreen> createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  WorkoutDetailScreenService workoutDetailScreenService =
      WorkoutDetailScreenService();

  var isLoaded = false;
  var randomColor = Colors.black;

  @override
  void initState() {
    super.initState();
    print(widget.workoutId);
    workoutDetailScreenService.getData(widget.workoutId).then((value) {
      setState(() {
        isLoaded = true;
      });
    });
    workoutDetailScreenService.generateRandomColor().then((value) {
      setState(() {
        randomColor = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        backgroundColor: randomColor,
      ),
      body: SafeArea(
        child: Visibility(
          visible: isLoaded,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [randomColor, Colors.black],
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    color: Colors.black
                        .withOpacity(0.1), // Adjust opacity as needed
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 4, // Workout image takes 40% of the screen
                    child: Container(
                      padding: EdgeInsets.all(48.0),
                      child: AspectRatio(
                        aspectRatio: 1.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            isLoaded
                                ? workoutDetailScreenService
                                        .workout?.first.workoutImageUrl ??
                                    'https://hips.hearstapps.com/hmg-prod/images/unknown-african-american-athlete-lifting-dumbbell-royalty-free-image-1669374545.jpg?crop=0.90609xw:1xh;center,top&resize=1200:*'
                                : 'https://hips.hearstapps.com/hmg-prod/images/unknown-african-american-athlete-lifting-dumbbell-royalty-free-image-1669374545.jpg?crop=0.90609xw:1xh;center,top&resize=1200:*',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6, // Bottom part takes 60% of the screen
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            isLoaded
                                ? workoutDetailScreenService
                                        .workout?.first.name ??
                                    'Workout Name'
                                : 'Workout Name',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: workoutDetailScreenService
                                  .workoutExercises!.length,
                              itemBuilder: (BuildContext context, int index) {
                                final workoutExercise =
                                    workoutDetailScreenService
                                        .workoutExercises![index];
                                return WorkoutExerciseListTile(
                                  name: workoutExercise.exerciseData.name,
                                  gifUrl: workoutExercise.exerciseData.gifUrl,
                                  reps: workoutExercise.reps,
                                  sets: workoutExercise.sets,
                                  weight: workoutExercise.weight,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
