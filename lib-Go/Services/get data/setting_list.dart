import 'dart:convert';

import '../../Config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class SettingController extends GetConnect{
  String?service;
  RxList<dynamic>settingdata=<dynamic>[].obs;

  Future<dynamic> SettingApi(BuildContext context)async{
    service=ApiConfig.service;


    final baseurl="${service}/api/V1/getsettings/1";

    final url=Uri.parse(baseurl);

    final responce=await http.get(url);

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      final value=(data['data']);
      settingdata.assignAll([value]);
      return responce;
    }
    else{
      return responce;
    }
  }
}