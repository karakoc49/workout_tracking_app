import 'package:flutter/material.dart';
import 'package:workout_tracking_app/models/Workout.dart';
import 'package:workout_tracking_app/services/api_service.dart';
import 'package:workout_tracking_app/ui/screens/test.dart';
import 'package:workout_tracking_app/ui/widgets/AppBar.dart';
import 'package:workout_tracking_app/ui/widgets/BottomNavBar.dart';
import 'package:workout_tracking_app/ui/widgets/WorkoutListTile.dart';
import 'package:workout_tracking_app/utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final apiService = ApiService();
  List<Workout>? workouts;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    workouts = await apiService.getWorkouts();
    if (workouts != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBarWidget(
        backgroundColor: appBarColor,
      ),
      bottomNavigationBar: BottomBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ExerciseListTest()),
          );
        },
        child: Icon(
          Icons.local_hospital,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Welcome back,',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
            SizedBox(height: 18),
            Text(
              'Get your body changing within 6 weeks',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Text(
              '4-day strength program with compound lifts and progressive overload for muscle growth and balanced development.',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
            ),
            SizedBox(height: 15),
            Text(
              'Workouts',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            isLoaded
                ? Expanded(
                    child: ListView.builder(
                      itemCount: workouts?.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final workout = workouts![index];
                        return WorkoutListTile(
                          id: workout.id,
                          name: workout.name,
                          description: workout.description,
                        );
                      },
                    ),
                  )
                : Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
