import 'package:flutter/material.dart';

import 'package:promodoro_app/controller/entry_controller.dart';
import 'package:promodoro_app/models/response_models.dart';
import 'package:promodoro_app/screens/workhistory_screen.dart';
import 'package:promodoro_app/widgets/custom_dialog.dart';
import 'package:provider/provider.dart';

class PomodoroScreen extends StatefulWidget {
  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  ResponseModel responseModel = ResponseModel(message: '', status: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pomodoro Timer'),
      ),
      body: Consumer<EntryProviderController>(
          builder: (context, value, child) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      value.timeLeft.toString(),
                      style: const TextStyle(fontSize: 48),
                    ),
                    const SizedBox(height: 20),
                    if (!value.isRunning)
                      ElevatedButton(
                        onPressed: () {
                          value.startTimer(context);
                        },
                        child: const Text('Start Timer'),
                      ),
                    if (value.isRunning && !value.isPaused)
                      ElevatedButton(
                        onPressed: () {
                          value.pauseTimer();
                        },
                        child: const Text('Pause Timer'),
                      ),
                    ElevatedButton(
                      onPressed: () {
                        value.resetTimer();
                      },
                      child: const Text('Reset Timer'),
                    ),
                  ],
                ),
              )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WorkHistoryScreen()),
          );
        },
        child: const Icon(Icons.history),
      ),
    );
  }
}
