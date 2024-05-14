import 'package:flutter/material.dart';
import 'package:workout_tracking_app/services/add_workout_screen_service.dart';
import 'package:workout_tracking_app/ui/screens/WorkoutDetailScreen.dart';

import '../../models/Workout.dart';

class AddWorkoutScreen extends StatefulWidget {
  const AddWorkoutScreen({super.key});

  @override
  State<AddWorkoutScreen> createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  TextEditingController _workoutNameController = TextEditingController();
  AddWorkoutScreenService _addWorkoutScreenService = AddWorkoutScreenService();

  Future<void> createWorkout(String workoutName) async {
    // Handle empty workout name string
    if (workoutName.isEmpty) {
      return;
    }

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
      // Handle any errors that occurred during the API request
      print('Error creating workout: $e');
      // You can show an error message or take other appropriate action here
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
        decoration: BoxDecoration(
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
              Text(
                'Give your workout a name',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16), // Add some space
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: _workoutNameController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
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
              SizedBox(height: 32), // Add some space
              Container(
                width: MediaQuery.of(context).size.width *
                    0.8, // Set button width based on screen size
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 16.0),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.transparent, // White text color
                        side: BorderSide(
                            color: Colors.white), // White border color
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        String workoutName = _workoutNameController.text.trim();
                        createWorkout(workoutName);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 16.0),
                        child: Text(
                          'Create',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green, // White text color
                        side: BorderSide(
                            color: Colors.green), // Green border color
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
