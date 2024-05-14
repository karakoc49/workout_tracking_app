import 'package:flutter/material.dart';
import 'package:workout_tracking_app/services/home_page_service.dart';
import 'package:workout_tracking_app/ui/screens/AddWorkoutScreen.dart';
import 'package:workout_tracking_app/ui/widgets/AppBar.dart';
import 'package:workout_tracking_app/ui/widgets/WorkoutListTile.dart';
import 'package:workout_tracking_app/utils/constants.dart';

import '../../models/Workout.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageService homePageService = HomePageService();
  var isLoaded = false;
  List<Workout>? workouts;

  @override
  void initState() {
    super.initState();
    homePageService.getData().then((value) {
      setState(() {
        workouts = value;
        isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBarWidget(backgroundColor: appBarColor),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddWorkoutScreen()));
        },
        child: Icon(Icons.add, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Welcome back,',
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text('Get your body changing within 6 weeks',
                        style: Theme.of(context).textTheme.headline6),
                    const SizedBox(height: 20),
                    Text(
                      '4-day strength program with compound lifts and progressive overload for muscle growth and balanced development.',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const SizedBox(height: 20),
                    Text('Workouts',
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    FutureBuilder(
                      future: homePageService.getData(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error loading data'));
                        } else {
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              final workout = snapshot.data[index];
                              return WorkoutListTile(
                                id: workout.id,
                                name: workout.name,
                                description: workout.description,
                                imageUrl: workout.workoutImageUrl,
                              );
                            },
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
