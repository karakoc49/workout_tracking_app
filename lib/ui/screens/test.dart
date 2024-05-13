import 'package:flutter/material.dart';
import 'package:workout_tracking_app/services/test_service.dart';

import '../../models/Workout.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final TestService _testService = TestService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout App'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _testService.postWorkoutToApi(Workout(
              id: 4,
              name: 'Day 4 Workout',
              description: 'Thursday workout.',
              user: 1,
              workoutImageUrl:
                  'https://yt3.ggpht.com/yti/ANjgQV_7FgD3f75vwacPBiCcWse5wV7ebLTcAC8nH7WIKqrQY3U=s88-c-k-c0x00ffffff-no-rj', // Replace with your image URL
            ));
          },
          child: Text('Post Workout Data'),
        ),
      ),
    );
  }
}
