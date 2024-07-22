import 'dart:convert';
import '../../Config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonAnnouncementController extends GetConnect{
  String ?service;
  RxList<dynamic>commonannouncementdata=<dynamic>[].obs;
  String?token;

  Future<dynamic>CommonAnnouncementApi(BuildContext context)async{

    final SharedPreferences shref=await SharedPreferences.getInstance();
    var userdata=shref.getString('token');
    token=userdata??'';
    service=ApiConfig.service;

    final baseurl="${service}/api/v1/getallannouncement/general";

    final url=Uri.parse(baseurl);

    final header={
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Authorization':'$token'
    };

    final responce=await http.get(url,headers: header);

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      final value=(data['announcementWithSports']);
      commonannouncementdata.assignAll(value);
      return responce;
    }
    else{
      return responce;
    }
  }
}