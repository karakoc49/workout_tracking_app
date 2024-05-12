import 'package:flutter/material.dart';

class WorkoutExerciseListTile extends StatefulWidget {
  final String name;
  final String gifUrl;
  final int reps;
  final int sets;
  final int weight;

  const WorkoutExerciseListTile({
    Key? key,
    required this.name,
    required this.gifUrl,
    required this.reps,
    required this.sets,
    required this.weight,
  }) : super(key: key);

  @override
  State<WorkoutExerciseListTile> createState() =>
      _WorkoutExerciseListTileState();
}

class _WorkoutExerciseListTileState extends State<WorkoutExerciseListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(widget.gifUrl),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              widget.name,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          SizedBox(height: 8), // Add spacing
          Row(
            children: [
              Expanded(
                flex: 1,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Sets: ${widget.sets}',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                flex: 1,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Reps: ${widget.reps}',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                flex: 1,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Weight: ${widget.weight} kg',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      trailing: Icon(Icons.play_circle_filled,
          color: Colors.white), // Playback control
      onTap: () {
        // Play the selected track
      },
    );
  }
}
