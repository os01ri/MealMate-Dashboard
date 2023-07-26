import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../helper/helper_functions.dart';
import '../handling_exception_request.dart';

typedef FromJson<T> = T Function(String body);

class DeleteApi<T> with HandlingExceptionRequest {
  final Uri uri;
  final FromJson fromJson;
  DeleteApi({
    required this.uri,
    required this.fromJson,
  });
  Future<T> callRequest() async {
    String? token = await HelperFunctions.getToken();
    String fcmToken = await HelperFunctions.getFCMToken();
    bool isAuth = await HelperFunctions.isAuth();
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if(!kIsWeb)
        'fcm_token': fcmToken,
        if (isAuth) 'Authorization': 'Bearer $token',
      };
      var request = http.Request('DELETE', uri);
      request.headers.addAll(headers);
      http.StreamedResponse streamedResponse =
          await request.send().timeout(const Duration(seconds: 20));
      http.Response response = await http.Response.fromStream(streamedResponse);
      log(response.body);
      if (response.statusCode == 200) {
        return fromJson(response.body);
      } else {
        Exception exception = getException(response: response);
        throw exception;
      }
    } on HttpException {
      log(
        'http exception',
        name: 'RequestManager get function',
      );
      rethrow;
    } on FormatException {
      log(
        'something went wrong in parsing the uri',
        name: 'RequestManager get function',
      );
      rethrow;
    } on SocketException {
      log(
        'socket exception',
        name: 'RequestManager get function',
      );
      rethrow;
    } catch (e) {
      log(
        e.toString(),
        name: 'RequestManager get function',
      );
      rethrow;
    }
  }
}
