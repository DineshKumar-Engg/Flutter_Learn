import 'dart:convert';
import 'package:connect_athlete_admin/Config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetallAthleteController extends GetConnect{

  String?service,token;
  RxList<dynamic> getallathletedata=<dynamic>[].obs;

  Future<dynamic> GetallathleteApi(BuildContext context)async{
    final SharedPreferences shref=await SharedPreferences.getInstance();
    var gettoken=shref.getString('token');
    token=gettoken??'';

    service=ApiConfig.service;

    final url=Uri.parse("$service/api/v1/getallathlete");

    final header={
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Authorization':'$token'
    };

    final responce=await http.get(url,headers: header);

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      final value=(data['data']);
      getallathletedata.assignAll(value);
      return responce;
    }
    else{
      return responce;
    }

  }
}