import 'package:flutter/material.dart';
import 'package:workout_tracking_app/ui/screens/ExerciseDetailScreen.dart';

class ExerciseListTile extends StatefulWidget {
  final String name;
  final String description;
  final String muscleGroup;
  final String gifUrl;
  final Function(bool) onSelect;

  const ExerciseListTile({
    Key? key,
    required this.name,
    required this.description,
    required this.muscleGroup,
    required this.gifUrl,
    required this.onSelect,
  }) : super(key: key);

  @override
  State<ExerciseListTile> createState() => _ExerciseListTileState();
}

class _ExerciseListTileState extends State<ExerciseListTile> {
  bool isSelected = false;

  void navigateToDetailPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExerciseDetailScreen(
          name: widget.name,
          description: widget.description,
          muscleGroup: widget.muscleGroup,
          gifUrl: widget.gifUrl,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: navigateToDetailPage, // Navigate to detail page on card click
      child: Padding(
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
                    if (widget.gifUrl.isEmpty) // Check if gifUrl is empty
                      Center(
                        child: CircularProgressIndicator(),
                      ), // Display progress indicator
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
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5.0), // Add vertical spacing
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
                const SizedBox(width: 10.0), // Add horizontal spacing
                // Trailing - Checkbox
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSelected = !isSelected;
                      widget.onSelect(isSelected);
                    });
                  },
                  child: Checkbox(
                    value: isSelected,
                    onChanged: (bool? value) {
                      setState(() {
                        isSelected = value!;
                        widget.onSelect(isSelected);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
