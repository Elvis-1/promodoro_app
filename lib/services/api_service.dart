import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:promodoro_app/constant.dart';

class ApiService with ChangeNotifier {
  String? appBaseUrl = AppConstants.SERVER_API_URL;
  late Map<String, String> _mainHeaders;

  ApiService() {
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };
  }

/**  Method to send data to backend**/

  Future<http.Response> postData(String url, body) async {
    print('got to api client');

    try {
      final response = await http
          .post(
            Uri.parse(AppConstants.SERVER_API_URL + url),
            headers: _mainHeaders,
            body: body,
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 201) {
        // Request was successful, return the response
        print(jsonDecode(response.body).toString());
        return response;
      } else {
        // Request failed with a non-2XX status code
        http.Response('Error: ${response.reasonPhrase}', response.statusCode);
        print('Failed with non 2XX status code  ' +
            jsonDecode(response.body).toString());

        return response;
      }
    } on TimeoutException {
      return http.Response('Network Timeout', 500);
    } on http.ClientException catch (e) {
      return http.Response('HTTP Client Exception: $e', 500);
    } catch (e) {
      // Handle any other exceptions here
      var resp = http.Response('Error: $e', 504);
      print('Other exception  ' + resp.reasonPhrase.toString());

      return resp;
    }
  }

/*  Method to accept data from backend  **/

  Future<http.Response> getData(url) async {
    try {
      var response = await http.get(
          Uri.parse(AppConstants.SERVER_API_URL + url),
          headers: _mainHeaders);
      return response;
    } catch (e) {
      print(e.toString());
      var resp = http.Response('Error: $e', 504);
      return resp;
    }
  }
}
