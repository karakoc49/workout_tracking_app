import 'package:flutter/material.dart';
import 'package:workout_tracking_app/services/home_page_service.dart';
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
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      appBar: const AppBarWidget(backgroundColor: appBarColor),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Welcome back, Haluk!',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text('Get your body changing within weeks',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 20),
                    Text('Workouts',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    FutureBuilder(
                      future: homePageService.getData(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: Text(
                              snapshot.error.toString(),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  homePageService.getData();
                                },
                                child: const Text('Try again'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Close'),
                              ),
                            ],
                          );
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
