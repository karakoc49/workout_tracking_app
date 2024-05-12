import 'package:flutter/material.dart';

class ExerciseListTile extends StatefulWidget {
  final String name;
  final String description;
  final String muscleGroup;
  final String gifUrl;

  const ExerciseListTile({
    super.key,
    required this.name,
    required this.description,
    required this.muscleGroup,
    required this.gifUrl,
  });

  @override
  State<ExerciseListTile> createState() => _ExerciseListTileState();
}

class _ExerciseListTileState extends State<ExerciseListTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black12
                    .withOpacity(0.2), // Adjust opacity for subtle shadow
                blurRadius: 5.0, // Increase blur radius for softer shadow
                spreadRadius: 0.5,
              )
            ],
          ),
          child: Padding(
            padding:
                const EdgeInsets.all(10.0), // Add padding for content spacing
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // Align content horizontally
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
                            child:
                                CircularProgressIndicator()) // Display progress indicator
                        : SizedBox(), // Empty container if image is available
                  ],
                ),
                // Title & Subtitle - Aligned vertically
                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align text left
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                        height: 5.0), // Add spacing between title and subtitle
                    Text(
                      widget.muscleGroup,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey[600], // Use a grey tone
                      ),
                    ),
                  ],
                ),
                // Trailing - Check icon with hover effect
                InkWell(
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
        SizedBox(height: 20.0), // Add spacing between list items
      ],
    );
  }
}
