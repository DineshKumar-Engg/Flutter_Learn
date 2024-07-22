import 'dart:convert';
import 'package:connect_athlete_admin/Config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Promocode_payment_Controller extends GetConnect{
  String?service,token;
  RxList<dynamic> getpromocodereports=<dynamic>[].obs;

  Future<dynamic> PromocodeReportApi(BuildContext context,sportid,startdate,enddate,roleid,promocodename)async{
    service=ApiConfig.service;

    final SharedPreferences shref=await SharedPreferences.getInstance();
    var gettoken=shref.getString('token');
    token=gettoken??'';

    final url=Uri.parse("$service/api/v1/promocodepurchasereport?sportId=$sportid&roleId=$roleid&promocodeName=$promocodename&startDate$startdate=&EndDate=$enddate&isEnable=");

    final header={
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Authorization':'$token'
    };

    final responce=await http.get(url,headers: header);

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      final value=(data['transactionHistories']);
      getpromocodereports.assignAll(value);
      return responce;

    }
    else{
      return responce;
    }
  }
}