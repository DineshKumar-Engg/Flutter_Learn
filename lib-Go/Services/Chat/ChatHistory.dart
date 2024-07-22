import 'dart:convert';

import 'package:connect_athelete/Config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChatHistoyController extends GetConnect{
  String?service;
  int?userid;
  RxList<dynamic> chathistorydata=<dynamic>[].obs;

  Future<dynamic> ChatHistoryApi(BuildContext context,receiverid)async{

    final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var getuserid=sharedPreferences.getInt('userid');
    userid=getuserid??0;

    service=ApiConfig.service;

    final url=Uri.parse("$service/api/messages/$userid/$receiverid");

    final responce=await http.get(url);

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      final value=(data);
      chathistorydata.assignAll(value);
      return responce;
    }
else{
  return responce;
    }
  }
}