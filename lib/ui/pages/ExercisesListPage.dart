import 'package:flutter/material.dart';
import 'package:workout_tracking_app/ui/widgets/AppBar.dart';
import 'package:workout_tracking_app/utils/responsive_padding.dart';

import '../widgets/ExerciseListTile.dart';
import '/models/Exercise.dart';
import '/services/api_service.dart';

final TextEditingController _searchController = TextEditingController();

class ExerciseListPage extends StatefulWidget {
  const ExerciseListPage({super.key});

  @override
  State<ExerciseListPage> createState() => _ExerciseListPageState();
}

class _ExerciseListPageState extends State<ExerciseListPage> {
  final apiService = ApiService();
  List<Exercise>? exercises;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    exercises = await ApiService().getExercises();
    if (exercises != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBarWidget(backgroundColor: Colors.lightBlue[50]!),
      body: ResponsivePadding(
        padding: 14.0,
        child: Column(
          children: [
            const Text(
              'Exercises',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
            SizedBox(
              height: 15,
            ),
            Visibility(
              visible: isLoaded,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: Expanded(
                child: ListView.builder(
                  itemCount: exercises?.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final exercise = exercises![index];
                    return ExerciseListTile(
                        name: exercise.name,
                        description: exercise.description,
                        muscleGroup: exercise.muscleGroup,
                        gifUrl: exercise.gifUrl);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
