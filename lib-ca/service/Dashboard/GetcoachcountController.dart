import 'dart:convert';
import 'package:connect_athlete_admin/Config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetCoachprofilecountController extends GetConnect{
  String?service,token;
  RxList<dynamic> getcoachprofiledata=<dynamic>[].obs;

  Future<dynamic> GetCoachprofilecountApi(BuildContext context)async{
    service=ApiConfig.service;

    final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var gettoken=sharedPreferences.getString('token');
    token=gettoken??'';

    final url=Uri.parse("$service/api/v1/coachprofiles?sportsId=&state=&asOfDate=");

    final header={
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Authorization':'$token'
    };

    final responce=await http.get(url,headers: header);

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      final value=(data);
      getcoachprofiledata.assignAll([value]);
      return responce;
    }
    else{
      return responce;
    }
  }
}