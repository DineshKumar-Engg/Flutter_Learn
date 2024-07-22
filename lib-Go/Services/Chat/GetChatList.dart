import 'dart:convert';

import 'package:connect_athelete/Config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetChatlistController extends GetConnect{
  
  String?service;
  int?userid;
  RxList<dynamic> getchatlistdata=<dynamic>[].obs;
  
  Future<dynamic>GetChatListApi(BuildContext context)async{

    final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var getuserid=sharedPreferences.getInt('userid');
    userid=getuserid??0;

    service=ApiConfig.service;
    
    final url=Uri.parse("$service/api/messages/connecteduser/$userid");

    final header={
      'Accept':'application/json',
      'Content-Type':'application/json'
    };

    final responce=await http.get(url,headers: header);

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      final value=(data);
      getchatlistdata.assignAll(value);
      return responce;
    }else{
      return responce;
    }
  }
}