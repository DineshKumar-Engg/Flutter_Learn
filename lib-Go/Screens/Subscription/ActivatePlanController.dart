import 'dart:convert';
import 'package:connect_athelete/Config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivatePlanController extends GetConnect{

  String?service,gettoken;
  int?userid;
  Future<void>ActivatePlanApi(BuildContext context,subscriptionid)async{

    final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var getuserid=sharedPreferences.getInt('userid');
    userid=getuserid??0;

    var token=sharedPreferences.getString('token');
    gettoken=token??'';

    service=ApiConfig.service;

    final url=Uri.parse("$service/api/v1/subscribtionissubscription");

    final header={
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Authorization':'$gettoken'
    };

    final json='{"userId":"$userid","subscriptionId":"$subscriptionid"}';

    final responce=await http.post(url,headers: header,body: json.toString());

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      print(data);
      print("plan Activated");
    }
  else{
      print("Error plan Activated${responce.statusCode}");
    }
  }
}