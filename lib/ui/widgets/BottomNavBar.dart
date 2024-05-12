import 'package:flutter/material.dart';
import 'package:workout_tracking_app/ui/pages/ExercisesListPage.dart';
import 'package:workout_tracking_app/ui/pages/HomePage.dart';

import '../../utils/constants.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 6.0,
      color: Colors.transparent,
      elevation: 9.0,
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: 50,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: SizedBox(
                height: 50.0,
                width: MediaQuery.of(context).size.width / 2 - 40.0,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.home,
                      color: Colors.lightBlue,
                      size: 35,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ExerciseListPage()));
              },
              child: SizedBox(
                height: 50.0,
                width: MediaQuery.of(context).size.width / 2 - 40.0,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      color: passiveColor,
                      size: 35,
                    ),
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
