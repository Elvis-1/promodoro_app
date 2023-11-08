import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:promodoro_app/models/work_entry_model.dart';

import 'package:promodoro_app/services/api_service.dart';
import 'package:promodoro_app/constant.dart';
import 'package:promodoro_app/models/response_models.dart';

class EntryRepository with ChangeNotifier {
  ApiService apiService;
  EntryRepository({required this.apiService});

  List<dynamic> data = [];
  // jsonDecode(response.body);
  List<WorkEntry> entries = [];
  // data.map((entry) => WorkEntry.fromJson(entry)).toList();
  // create entry to server

  Future<ResponseModel> createEntryOnServer(body) async {
    ResponseModel responseModel;
    try {
      final response = await apiService.postData(
          AppConstants.CREATE_ENTRY, jsonEncode(body));

      if (response.statusCode == 201) {
        // Entry created successfully
        responseModel =
            ResponseModel(message: "created successfully", status: true);
      } else {
        // Handle error
        var error = jsonDecode(response.body)['message'].toString();
        responseModel = ResponseModel(message: error, status: false);
      }
      return responseModel;
    } catch (e) {
      // Handle network or server error
      var error = "...Ooops something went wrong";
      print(error);
      responseModel = ResponseModel(message: error, status: false);
      return responseModel;
    }
  }

  fetchEntriesFromServer() async {
    ResponseModel responseModel;
    try {
      final response = await apiService.getData(AppConstants.FETCH_ENTRIES);

      if (response.statusCode == 200) {
        responseModel = ResponseModel(message: 'Successful', status: true);
        return response;
      } else {
        // Handle error
        var error = jsonDecode(response.body)['message'].toString();
        responseModel = ResponseModel(message: error, status: false);
        return response;
      }
    } catch (e) {
      // Handle network or server error
      var error = "...Ooops something went wrong";
      print(e.toString());
      responseModel = ResponseModel(message: error, status: false);
      return responseModel;
    }
  }
}
