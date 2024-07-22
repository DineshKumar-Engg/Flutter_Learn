import 'dart:convert';
import 'package:connect_athlete_admin/Config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class Getspeciality_Controller extends GetConnect{

  String?service,token;
  RxList<dynamic> getspeciality_data=<dynamic>[].obs;

  Future<dynamic> GetspecialityApi(BuildContext context)async{
    final SharedPreferences shref=await SharedPreferences.getInstance();
    var gettoken=shref.getString('token');
    token=gettoken??'';

    service=ApiConfig.service;
    
    final url=Uri.parse("$service/api/v1/getallspeciality");

    final header={
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Authorization':'$token'
    };

    final responce=await http.get(url,headers: header);

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      final value=(data['specialityData']);
      getspeciality_data.assignAll(value);
      return responce;
    }
    else{
      return responce;
    }

  }
}