import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/connect.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Config.dart';
class OverallprofileController extends GetConnect{

  String?service,token;
  RxList<dynamic>overallprofiledata=<dynamic>[].obs;

  Future<dynamic>OverallprofileApi(BuildContext context)async{
    service=ApiConfig.service;

    final SharedPreferences shref=await SharedPreferences.getInstance();
    var gettoken=shref.getString('token');
    token=gettoken??'';
    final baseurl="$service/api/v1/overallprofiles";

    final url=Uri.parse(baseurl);

    final header={
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Authorization':'$token'
    };

    final responce=await http.get(url,headers: header);

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      final value=(data);
      overallprofiledata.assignAll([value]);
      return responce;
    }
    else{
      return responce;
    }
  }
}