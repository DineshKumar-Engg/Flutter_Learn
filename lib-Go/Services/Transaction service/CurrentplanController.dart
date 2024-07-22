import 'dart:convert';

import 'package:connect_athelete/Config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Currentplancontroller extends GetConnect{

  String?service,token;
  int?userid;
  RxList<dynamic>currentplandata=<dynamic>[].obs;

  Future<dynamic>CurrentplanApi(BuildContext context)async{
    final SharedPreferences shref=await SharedPreferences.getInstance();
    var gettoken=shref.getString('token');
    token=gettoken??'';

    var getuserid=shref.getInt('userid');
    userid=getuserid??0;

    service=ApiConfig.service;

    final url=Uri.parse("$service/api/v1/currenttransactionhistory/$userid");

    final header={
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Authorization':'$token'
    };

    final responce=await http.get(url,headers: header);

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      final value=(data['data']);
      currentplandata.assignAll(value);
      return responce;
    }
    else{
      return responce;
    }
  }
}