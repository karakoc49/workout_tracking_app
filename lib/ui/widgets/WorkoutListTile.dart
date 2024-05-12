import 'package:flutter/material.dart';

import '../screens/WorkoutDetailScreen.dart';

class WorkoutListTile extends StatefulWidget {
  final int id;
  final String name;
  final String description;

  const WorkoutListTile({
    super.key,
    required this.id,
    required this.name,
    required this.description,
  });

  @override
  State<WorkoutListTile> createState() => _WorkoutListTileState();
}

class _WorkoutListTileState extends State<WorkoutListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 0.2,
                offset: Offset(0.3, 0.5),
                spreadRadius: 0.5)
          ]),
      child: ListTile(
        title: Text(widget.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        subtitle: Text(widget.description,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
        trailing: Container(
          decoration: BoxDecoration(
            color: Colors.lightBlue,
            borderRadius: BorderRadius.circular(50),
          ),
          child: InkWell(
            child: Icon(
              Icons.check,
              color: Colors.white,
            ),
            onTap: () {
              print("Workout List Tile Workout Id: ${widget.id}");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          WorkoutDetailScreen(workoutId: widget.id)));
            },
          ),
        ),
      ),
    );
  }
}
