import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:workout_tracking_app/services/edit_workout_exercise_service.dart';

import '../../models/WorkoutExercise.dart';
import '../widgets/AppBar.dart';

class EditWorkoutExerciseScreen extends StatefulWidget {
  final int workoutExerciseId;
  final int workoutId;
  final int exerciseId;
  final String name;
  final String gifUrl;
  final int sets;
  final int reps;
  final int weight;

  const EditWorkoutExerciseScreen(
      {super.key,
      required this.workoutExerciseId,
      required this.workoutId,
      required this.exerciseId,
      required this.name,
      required this.gifUrl,
      required this.sets,
      required this.reps,
      required this.weight});

  @override
  State<EditWorkoutExerciseScreen> createState() =>
      _EditWorkoutExerciseScreenState();
}

class _EditWorkoutExerciseScreenState extends State<EditWorkoutExerciseScreen> {
  final EditWorkoutExerciseService _editWorkoutExerciseService =
      EditWorkoutExerciseService();

  late int _sets;
  late int _reps;
  late int _weight;

  @override
  void initState() {
    _sets = widget.sets;
    _reps = widget.reps;
    _weight = widget.weight;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            _editWorkoutExerciseService.showConfirmationDialog(context);
          },
        ),
        centerTitle: true,
        title: Text(
          widget.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 4, // Workout image takes 40% of the screen
              child: Container(
                padding: const EdgeInsets.all(24.0),
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      widget.gifUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6, // Bottom part takes 60% of the screen
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Text(
                          'Sets',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                        NumberPicker(
                          value: _sets,
                          minValue: 1,
                          maxValue: 100,
                          itemHeight: 100,
                          selectedTextStyle: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          axis: Axis.horizontal,
                          onChanged: (value) => setState(() => _sets = value),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.black26),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Column(
                      children: [
                        Text(
                          'Reps',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                        NumberPicker(
                          value: _reps,
                          minValue: 1,
                          maxValue: 100,
                          itemHeight: 100,
                          selectedTextStyle: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          axis: Axis.horizontal,
                          onChanged: (value) => setState(() => _reps = value),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.black26),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Column(
                      children: [
                        Text(
                          'Weight (kg)',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                        NumberPicker(
                          value: _weight,
                          minValue: 1,
                          maxValue: 1000,
                          itemHeight: 100,
                          selectedTextStyle: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          axis: Axis.horizontal,
                          onChanged: (value) => setState(() => _weight = value),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.black26),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  _editWorkoutExerciseService.saveWorkoutExercise(
                      WorkoutExercise(
                        id: widget.workoutExerciseId,
                        workout: widget.workoutId,
                        exercise: widget.exerciseId,
                        sets: _sets,
                        reps: _reps,
                        weight: _weight,
                      ),
                      widget.workoutExerciseId,
                      context);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                ),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
