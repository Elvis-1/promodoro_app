import 'package:flutter/material.dart';

showDialogueBox(BuildContext context, String msg, String title) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
          ),
          content: Text(
            msg,
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Okay")),
            // TextButton(onPressed: func, child: const Text("Confirm"))
          ],
        );
      });
  // return Container(
  //   child: Center(
  //       child: Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Text("Created successfully"),
  //       TextButton(
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           },
  //           child: Text('Exit'))
  //     ],
  //   )),
  // );
}
