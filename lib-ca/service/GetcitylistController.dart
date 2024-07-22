import 'dart:convert';

import '../../Config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';

class CitylistController extends GetConnect{
  String?service;
  RxList<dynamic> citydata=<dynamic>[].obs;

  Future<dynamic> CitylistApi(BuildContext context,stateid)async{
    service=ApiConfig.service;

    final baseurl="${service}/api/v1/getallcities?stateId=$stateid";

    final url=Uri.parse(baseurl);

    final responce=await http.get(url);

    final data=jsonDecode(responce.body);
    print(data);

    if(responce.statusCode==200){
      final value=(data['citiesData']);
      citydata.assignAll(value);
      return responce;
    }
    else{
      return responce;
    }
  }
}