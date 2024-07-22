import 'dart:convert';
import 'package:connect_athelete/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';

class GetallCitiesController extends GetConnect{

  String?service;
  RxList<dynamic>getcitiesdata=<dynamic>[].obs;

  Future<dynamic>GetallCitiesApi(BuildContext context)async{
    service=ApiConfig.service;

    final baseurl="$service/api/v1/allcities";

    final url=Uri.parse(baseurl);

    final responce=await http.get(url);

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      final value=(data['citiesData']);
      getcitiesdata.assignAll(value);
      return responce;
    }
    else{
      return responce;
    }
  }
}