import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mealmate_dashboard/core/extensions/widget_extensions.dart';
import 'package:mealmate_dashboard/core/helper/file_uploader/platform_file_picker.dart';
import 'package:mealmate_dashboard/core/ui/widgets/loading_widget.dart';
import 'package:path/path.dart' as path;
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
class UploadService{


  static Future<dynamic> uploadFile({required String url,required FlutterWebFile file,Map<String,String>? extraBody,String fileName="image",
    required Function success,required Function failed,required BuildContext context
  }) async {

    Map<String, dynamic> fields = {
    };

    var request = http.MultipartRequest(
      "POST", Uri.parse(url),
    );

    request.files.add(
      http.MultipartFile.fromBytes(
        'image', file.fileBytes,
//  contentType: MediaType('application', 'octet-stream'),
        filename: file.file.name,
      ),
    );

    fields.forEach((k, v) => request.fields[k] = v);

    request.headers.addAll(
      {
        'Content-Type': 'application/json',
        'Authorization': "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjg3MjEyMDMyLCJleHAiOjE2ODc1NzIwMzJ9.6V1KxM41yX3-gFvs6GyGEkd_W95oeqvzUl5IEpuYnv0",
      },
    );

    showDialog<dynamic>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            child: Container(
              width: MediaQuery.of(context).size.width*0.6,
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(24.0),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(right: 20, left: 20, top: 10),
                      child: Center(
                          child: Text(
                            'Uploading File...',
                          )),
                    ),
                  ),
                  Center(
                    child: LoadingWidget().center(),
                  ),
                  SizedBox(height: 6,)
                ],
              ),
            ),
          );
        });

      try {
        var streamedResponse = await request.send();

      Navigator.of(context).pop();
      print(streamedResponse.statusCode);
        if (streamedResponse.statusCode == 200)
        {
          var _result = await http.Response.fromStream(streamedResponse);
          var value = (jsonDecode(_result.body));
          print(value);
          success(value);
        }
        else
        {
          failed(-1);
        }

      }
      catch(e){
        print(e);
        Navigator.of(context).pop();

          failed(-1);

      }
  }

}