import 'package:flutter/material.dart';
import 'package:workout_tracking_app/ui/widgets/AppBar.dart';

import '../../services/edit_workout_screen_service.dart';

class EditWorkoutScreen extends StatefulWidget {
  final String workoutName;
  final String workoutDescription;
  final String workoutImageUrl;

  const EditWorkoutScreen(
      {super.key,
      required this.workoutName,
      required this.workoutDescription,
      required this.workoutImageUrl});

  @override
  State<EditWorkoutScreen> createState() => _EditWorkoutScreenState();
}

class _EditWorkoutScreenState extends State<EditWorkoutScreen> {
  EditWorkoutScreenService _editWorkoutScreenService =
      EditWorkoutScreenService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            _editWorkoutScreenService.showConfirmationDialog(context);
          },
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
                padding: EdgeInsets.all(48.0),
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        widget.workoutImageUrl,
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            ),
            Expanded(
              flex: 6, // Bottom part takes 60% of the screen
              child: Column(
                children: [
                  Text(
                    widget.workoutName,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    widget.workoutDescription,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
