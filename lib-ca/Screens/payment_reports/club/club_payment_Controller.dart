import 'dart:convert';
import 'package:connect_athlete_admin/Config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Club_payment_Controller extends GetConnect{
  String?service,token;
  RxList<dynamic> getclubreports=<dynamic>[].obs;

  Future<dynamic> ClubReportApi(BuildContext context,academiename,publish,email,subscription,state,city,sportid,startdate,enddate)async{
    service=ApiConfig.service;

    final SharedPreferences shref=await SharedPreferences.getInstance();
    var gettoken=shref.getString('token');
    token=gettoken??'';

    final url=Uri.parse("$service/api/v1/academiereport?academieName=$academiename&isPublish=$publish&email=$email&isSubscription=$subscription&residentialState=$state&city=$city&sportsId=$sportid&startDate=$startdate&endDate=$enddate");

    final header={
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Authorization':'$token'
    };

    final responce=await http.get(url,headers: header);

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      final value=(data['users']);
      getclubreports.assignAll(value);
      return responce;

    }
    else{
      return responce;
    }
  }
}