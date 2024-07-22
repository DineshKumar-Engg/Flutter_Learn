import 'dart:convert';
import 'package:connect_athelete/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ImageuploadController extends GetConnect{
  String ?service;
  String token='';
  int?userid;

  RxList<dynamic> imagedata=<dynamic>[].obs;

  Future<dynamic>ImageUploadApi(BuildContext context,img) async {
    final SharedPreferences shref = await SharedPreferences.getInstance();
    var gettoken = shref.getString('token');
    token = gettoken ?? '';

    var getid = shref.getInt('userid');
    userid = (getid ?? '') as int;


    service = ApiConfig.service;
    final  baseurl = "${service}/api/v1/upload-singlefiletest";

    final fileLocation = json.encode(img);
    final response = await http.post(
      Uri.parse(baseurl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':'$token'
      },
      body: json.encode({
        "fileLocation":fileLocation,
        "isActive": true,
        "description": "profile Hasan Al Haydos Qatar Japan Takumi Minamino",
        "fileType": "Profile Image",
        "isApproved": "Approved",
        "userId": userid,
        "ImageType":"image/png",
      }),
    );

    final data=jsonDecode(response.body);
    if (response.statusCode == 201) {
      final value=(data['data']);
      imagedata.assignAll(value);
      print('File uploaded successfully');
    } else {
      print('Failed to upload file: ${response.statusCode}');
    }
  }
}