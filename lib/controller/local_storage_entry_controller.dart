import 'package:flutter/material.dart';
import 'package:promodoro_app/services/local_storage_service.dart';

class LocalStorageController with ChangeNotifier {
  List<Map<String, dynamic>> workEntries = [];
  final dbHelper = DatabaseHelper();

  Future<void> fetchWorkHistory() async {
    final entries = await dbHelper.fetchWorkEntries();

    workEntries = entries;
    notifyListeners();
  }

  saveWorkEntryLocally(Map<String, dynamic> entry) async {
    await dbHelper.insertWorkEntry(entry);
    fetchWorkHistory();
  }
}
