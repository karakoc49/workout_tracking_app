import 'package:flutter/material.dart';

import '../screens/WorkoutDetailScreen.dart';

class WorkoutListTile extends StatelessWidget {
  final int id;
  final String name;
  final String description;
  final String imageUrl;

  const WorkoutListTile({
    Key? key,
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: ListTile(
        onTap: () {
          // Here you can define the navigation or any other interaction
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => WorkoutDetailScreen(workoutId: id),
            ),
          );
        },
        contentPadding: const EdgeInsets.all(10.0),
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          child: imageUrl != ''
              ? Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: 50,
                  height: 50,
                )
              : Text(name[0].toUpperCase(),
                  style: TextStyle(color: Colors.white)),
        ),
        title: Text(name, style: Theme.of(context).textTheme.headline6),
        subtitle: Text(
          description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subtitle2,
        ),
        trailing:
            Icon(Icons.chevron_right, color: Theme.of(context).primaryColor),
      ),
    );
  }
}
