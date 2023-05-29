import 'dart:developer';
import 'dart:io';

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
        'fcm_token': fcmToken,
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEzMTkyMmQ2LTI4M2ItNGMxZS1iMmI0LTdkODAwNWM4ZTkwYSIsImlhdCI6MTY4NTM4NDczNywiZXhwIjoxNjg1Mzg4MzM3fQ.igvaoHWxH-XRY6ViKMRjTK9sdZDYMEpNBibBTCpjntA",
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
