import 'package:flutter/material.dart';
import 'package:workout_tracking_app/ui/widgets/AppBar.dart';

import '../../models/Workout.dart';
import '../../services/edit_workout_screen_service.dart';

class EditWorkoutScreen extends StatefulWidget {
  final int workoutId;
  final String workoutName;
  final String workoutDescription;
  final String workoutImageUrl;

  const EditWorkoutScreen(
      {super.key,
      required this.workoutName,
      required this.workoutDescription,
      required this.workoutImageUrl,
      required this.workoutId});

  @override
  State<EditWorkoutScreen> createState() => _EditWorkoutScreenState();
}

class _EditWorkoutScreenState extends State<EditWorkoutScreen> {
  final EditWorkoutScreenService _editWorkoutScreenService =
      EditWorkoutScreenService();

  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageUrlController;
  late String _workoutImageUrl;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.workoutName);
    _descriptionController =
        TextEditingController(text: widget.workoutDescription);
    _imageUrlController = TextEditingController(text: widget.workoutImageUrl);
    _workoutImageUrl = widget.workoutImageUrl;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _changeImageUrl() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Workout Image URL'),
        content: TextField(
          onTap: () {
            _imageUrlController.clear();
          },
          controller: _imageUrlController,
          decoration: const InputDecoration(hintText: 'Enter new image URL'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _workoutImageUrl = _imageUrlController.text;
              });
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

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
              child: GestureDetector(
                onTap: _changeImageUrl,
                child: Container(
                  padding: const EdgeInsets.all(48.0),
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        _workoutImageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6, // Bottom part takes 60% of the screen
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Workout Name',
                        labelStyle: TextStyle(color: Colors.white70),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _descriptionController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Workout Description',
                        labelStyle: TextStyle(color: Colors.white70),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      maxLines: 4,
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
                  _editWorkoutScreenService.saveWorkout(
                      Workout(
                        id: widget.workoutId,
                        name: _nameController.text,
                        description: _descriptionController.text,
                        user: 1,
                        workoutImageUrl: _imageUrlController.text,
                      ),
                      widget.workoutId,
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
