import 'dart:convert';
import 'package:connect_athelete/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class Getallfavourite_Controller extends GetConnect{
  String?service;
 String token='';
 int?userid;
  RxList<dynamic> getallfavouritedata=<dynamic>[].obs;

  Future<dynamic>Getfavourite_Api(BuildContext context,roleid)async{

    final SharedPreferences shref=await SharedPreferences.getInstance();
    var getoken=shref.getString('token');
    token=getoken??'';

    var getuserid=shref.getInt('userid');
    userid=getuserid??0;

    service=ApiConfig.service;

    final url=Uri.parse("$service/api/v1/favoritesgetall?userId=$userid&roleId=$roleid");

    final header={
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Authorization':'$token'
    };

    final responce=await http.get(url,headers: header);
    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      final value=(data['data']);
      getallfavouritedata.assignAll(value);
      return responce;
    }
    else{
      return responce;
    }
  }
}