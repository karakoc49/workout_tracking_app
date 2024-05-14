import 'package:flutter/material.dart';

class EditWorkoutScreenService {
  Future<void> showConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Discard changes?'),
          content: Text('Do you want to discard your changes and go back?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Keep editing'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
              child: Text('Discard'),
            ),
          ],
        );
      },
    );
  }
}
