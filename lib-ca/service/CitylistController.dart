import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/connect.dart';

import '../Config.dart';

class GetallCitylistController extends GetConnect{

  String?service;
  RxList<dynamic>getcitylistdata=<dynamic>[].obs;

  Future<dynamic>GetCitylistApi(BuildContext context)async{
    service=ApiConfig.service;

    final baseurl="$service/api/v1/allcities";

    final url=Uri.parse(baseurl);

    final responce=await http.get(url);

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      final value=(data['citiesData']);
      getcitylistdata.assignAll(value);
      return responce;
    }
    else{
      return responce;
    }
  }
}