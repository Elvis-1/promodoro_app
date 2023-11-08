import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:promodoro_app/controller/local_storage_entry_controller.dart';
import 'package:promodoro_app/models/response_models.dart';
import 'package:promodoro_app/models/work_entry_model.dart';
import 'package:promodoro_app/repository/entry_repo.dart';
import 'dart:async';

import 'package:promodoro_app/widgets/custom_dialog.dart';

class EntryProviderController with ChangeNotifier {
  EntryRepository entryRepository;
  bool isRunning = false;
  bool isPaused = false;
  bool isLoading = false;
  Timer? timer;
  Duration timeLeft = const Duration(seconds: 10);
  EntryProviderController({required this.entryRepository});

  List<dynamic> data = [];
  // jsonDecode(response.body);
  List<WorkEntry> entries = [];

  startTimer({BuildContext? context}) {
    ResponseModel responseModel;
    isRunning = true;
    isPaused = false;
    notifyListeners();
    final endTime = DateTime.now().add(timeLeft);
    timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      notifyListeners();
      final now = DateTime.now();
      if (now.isAfter(endTime)) {
        Map<String, String> body = {
          'startTimestamp': DateTime.now().toIso8601String(),
          'stopTimestamp': DateTime.now().add(timeLeft).toIso8601String(),
        };
        // Make a POST request to create a time slot entry
        var resp = await entryRepository.createEntryOnServer(body);
        // print('Got here after resp');

        if (resp.status == true) {
          // save it locally
          LocalStorageController().saveWorkEntryLocally(body);
          if(context!.mounted){
          showDialogueBox(context, 'Successfully created', 'Successful');
          }

        }
        isRunning = false;
        isLoading = true;
        notifyListeners();
        resetTimer();
        timer.cancel();
      } else if (isPaused) {
        timer.cancel();
      } else {
        timeLeft = endTime.difference(now);
      }
      ;
    });
  }

  resetTimer() {
    isRunning = false;
    isPaused = false;
    notifyListeners();
    timeLeft = const Duration(minutes: 1);
    timer?.cancel();
  }

  pauseTimer() {
    isPaused = true;
    isRunning = false;
    notifyListeners();
  }

  fetchWorkEntries() async {
    var resp = await entryRepository.fetchEntriesFromServer();
    if (resp.statusCode == 200) {
      data = [];
      data = jsonDecode(resp.body);
      entries = data.map((entry) => WorkEntry.fromJson(entry)).toList();
      notifyListeners();
    } else {
      print(jsonDecode(resp.body).toString());
    }
  }
}
