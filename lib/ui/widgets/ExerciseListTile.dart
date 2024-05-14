import 'package:flutter/material.dart';

class ExerciseListTile extends StatefulWidget {
  final String name;
  final String description;
  final String muscleGroup;
  final String gifUrl;

  const ExerciseListTile({
    Key? key,
    required this.name,
    required this.description,
    required this.muscleGroup,
    required this.gifUrl,
  }) : super(key: key);

  @override
  State<ExerciseListTile> createState() => _ExerciseListTileState();
}

class _ExerciseListTileState extends State<ExerciseListTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        surfaceTintColor: Colors.white,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Leading - Image with progress indicator
              Stack(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                        widget.gifUrl), // Assuming gifUrl is not null
                  ),
                  widget.gifUrl.isEmpty // Check if gifUrl is empty
                      ? Center(
                          child: CircularProgressIndicator(),
                        ) // Display progress indicator
                      : SizedBox(), // Empty container if image is available
                ],
              ),
              SizedBox(width: 10.0), // Add horizontal spacing
              // Title & Subtitle - Aligned vertically
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0), // Add vertical spacing
                    Text(
                      widget.muscleGroup,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[600], // Use a grey tone
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.0), // Add horizontal spacing
              // Trailing - Check icon with hover effect
              GestureDetector(
                onTap: () {
                  // Handle tap on check icon
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
