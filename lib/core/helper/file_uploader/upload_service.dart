import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mealmate_dashboard/core/extensions/widget_extensions.dart';
import 'package:mealmate_dashboard/core/ui/widgets/loading_widget.dart';
import 'package:path/path.dart' as path;
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
class UploadService{


  static Future<dynamic> uploadFile({required String url,required File file,Map<String,String>? extraBody,String fileName="image",
    required Function success,required Function failed,required BuildContext context
  }) async {


      var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
      var length = await file.length();

      var uri = Uri.parse("$url");

      var request = new http.MultipartRequest("POST", uri);
      if(extraBody!=null)
      request.fields.addAll(extraBody);
      request.headers.addAll({"Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEzMTkyMmQ2LTI4M2ItNGMxZS1iMmI0LTdkODAwNWM4ZTkwYSIsImlhdCI6MTY4NTM5MTczOCwiZXhwIjoxNjg1Mzk1MzM4fQ.zYIvkOoeqfxJQKMDl2ly8gILenjvrKdsbwzcfwL1Fqo"});

      var multipartFile = new http.MultipartFile(fileName, stream, length,
          filename: path.basename(file.path));


      request.files.add(multipartFile);
      showDialog<dynamic>(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return Dialog(
              child: Container(
                child: ListView(
                  shrinkWrap: true,
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
        var response = await request.send();

      Navigator.of(context).pop();
      print(response.statusCode);
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
        if (response.statusCode == 200)
          {
                success(value);
          }
        else
          {
            failed(-1);
          }
      });

      }
      catch(e){

        Navigator.of(context).pop();

          failed(-1);

      }
  }

}