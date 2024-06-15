import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:workout_tracking_app/services/workout_detail_screen_service.dart';
import 'package:workout_tracking_app/ui/widgets/AppBar.dart';
import 'package:workout_tracking_app/ui/widgets/WorkoutExerciseListTile.dart';

import 'EditWorkoutScreen.dart';

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
  var randomColor = Colors.black;

  @override
  void initState() {
    super.initState();
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
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget(
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.center,
                colors: [randomColor, Colors.black],
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color:
                    Colors.black.withOpacity(0.1), // Adjust opacity as needed
              ),
            ),
          ),
          SafeArea(
            child: Visibility(
              visible: isLoaded,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: Column(
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
                          child: isLoaded &&
                                  workoutDetailScreenService
                                          .workout?.first.workoutImageUrl !=
                                      ""
                              ? Image.network(
                                  workoutDetailScreenService
                                          .workout?.first.workoutImageUrl ??
                                      'https://hips.hearstapps.com/hmg-prod/images/unknown-african-american-athlete-lifting-dumbbell-royalty-free-image-1669374545.jpg?crop=0.90609xw:1xh;center,top&resize=1200:*',
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/Hands-Clapping-Chaulk-Kettlebell.jpeg'),
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
                          Row(
                            children: [
                              PopupMenuButton(
                                itemBuilder: (context) {
                                  return [
                                    PopupMenuItem(
                                      child: const Text('Edit'),
                                      onTap: () {
                                        workoutDetailScreenService
                                                    .workout?.first !=
                                                null
                                            ? Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditWorkoutScreen(
                                                    workoutId: widget.workoutId,
                                                    workoutName:
                                                        workoutDetailScreenService
                                                                .workout
                                                                ?.first
                                                                .name ??
                                                            'Workout Name',
                                                    workoutDescription:
                                                        workoutDetailScreenService
                                                                .workout
                                                                ?.first
                                                                .description ??
                                                            'Workout Description',
                                                    workoutImageUrl:
                                                        workoutDetailScreenService
                                                                .workout
                                                                ?.first
                                                                .workoutImageUrl ??
                                                            'https://hips.hearstapps.com/hmg-prod/images/unknown-african-american-athlete-lifting-dumbbell-royalty-free-image-1669374545.jpg?crop=0.90609xw:1xh;center,top&resize=1200:*',
                                                  ),
                                                ),
                                              )
                                            : print('Workout is null');
                                      },
                                    ),
                                    PopupMenuItem(
                                      child: const Text('Delete'),
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Are you sure you want to delete this workout?'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    workoutDetailScreenService
                                                        .deleteWorkout(
                                                            widget.workoutId)
                                                        .then(
                                                            (deletionSuccessful) {
                                                      if (deletionSuccessful) {
                                                        Navigator.pop(
                                                            context); // Close the AlertDialog
                                                        Navigator.pop(
                                                            context); // Go back to the previous screen
                                                      } else {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                  'Error deleting workout. Please try again.'),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          'Ok'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      }
                                                    });
                                                  },
                                                  child: const Text('Delete'),
                                                )
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ];
                                },
                                color: Colors.white,
                                iconColor: Colors.white,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
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
                              itemCount:
                                  workoutDetailScreenService.mergedData.length,
                              itemBuilder: (BuildContext context, int index) {
                                final workoutExercise =
                                    workoutDetailScreenService
                                        .mergedData[index];
                                return WorkoutExerciseListTile(
                                  name: workoutExercise['exercise_data']
                                      ['name'],
                                  gifUrl: workoutExercise['exercise_data']
                                      ['gif_url'],
                                  reps: workoutExercise['reps'],
                                  sets: workoutExercise['sets'],
                                  weight: workoutExercise['weight'],
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
            ),
          ),
        ],
      ),
    );
  }
}
