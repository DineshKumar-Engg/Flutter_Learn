import 'dart:convert';
import 'package:connect_athlete_admin/Config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class CoachsearchController extends GetConnect{
  String?service,token;
  RxList<dynamic>coachsearchdata=[].obs;

  Future<dynamic> CoachsearchApi(BuildContext context,sportid,state,city,publish)async{
    service=ApiConfig.service;

    final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var gettoken=sharedPreferences.getString('token');
    token=gettoken??'';

    final url=Uri.parse("$service/api/v1/getallcoach?page=1&limit=1000&city=$city&residentialState=$state&sportsId=$sportid&isPublish=$publish");

    final header={
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Authorization':'$token'
    };

    final responce=await http.get(url,headers: header);

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      final value=(data['data']);
      coachsearchdata.assignAll([value]);
      return responce;
    }
    else{
      return responce;
    }
  }
}