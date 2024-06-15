import 'package:flutter/material.dart';
import 'package:workout_tracking_app/services/add_workout_screen_service.dart';
import 'package:workout_tracking_app/ui/screens/WorkoutDetailScreen.dart';
import 'package:workout_tracking_app/utils/constants.dart';

import '../../models/Workout.dart';

class AddWorkoutScreen extends StatefulWidget {
  const AddWorkoutScreen({super.key});

  @override
  State<AddWorkoutScreen> createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  TextEditingController _workoutNameController = TextEditingController();
  AddWorkoutScreenService _addWorkoutScreenService = AddWorkoutScreenService();

  bool _isSendingData = false;

  Future<void> createWorkout(String workoutName) async {
    // Prevent multiple requests
    if (_isSendingData) {
      return;
    }

    // Handle empty workout name string
    if (workoutName.isEmpty) {
      return;
    }

    setState(() {
      _isSendingData = true;
    });

    // Create a new workout
    Workout workout = Workout(
      id: 1,
      name: workoutName,
      description: 'My workout description',
      user: 1,
      workoutImageUrl: '',
    );

    try {
      // Add workout to the API and wait for the response
      Workout createdWorkout =
          await _addWorkoutScreenService.postWorkoutToApi(workout);

      // Close the screen and navigate to the detail screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              WorkoutDetailScreen(workoutId: createdWorkout.id),
        ),
      );
    } catch (e) {
      print('Error creating workout: $e');
    } finally {
      setState(() {
        _isSendingData = false; // Data sending process complete
      });
    }
  }

  @override
  void dispose() {
    _workoutNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.transparent, // Make Scaffold background transparent
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white30, Colors.white10],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Give your workout a name',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16), // Add some space
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: _workoutNameController,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: 'My workout',
                    hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.bold),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.white), // Underline color
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.white), // Underline color
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 32), // Add some space
              SizedBox(
                width: MediaQuery.of(context).size.width *
                    0.8, // Set button width based on screen size
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.transparent, // White text color
                        side: const BorderSide(
                            color: Colors.white), // White border color
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 16.0),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        String workoutName = _workoutNameController.text.trim();
                        createWorkout(workoutName);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: primaryColor, // White text color
                        side: const BorderSide(
                            color: primaryColor), // Green border color
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 16.0),
                        child: Text(
                          'Create',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
