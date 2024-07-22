import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import '../../Config.dart';

class StatelistController extends GetConnect{
  String?service;
  RxList<dynamic>statedata=<dynamic>[].obs;

  Future<dynamic>StatelistApi(BuildContext context)async{
    service=ApiConfig.service;

    final baseurl="${service}/api/V1/getallstates?stateId=0";

    final url=Uri.parse(baseurl);

    final responce=await http.get(url);

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      final value=(data['data']);
      statedata.assignAll(value);
      return responce;
    }
    else{
      return responce;
    }
  }
}