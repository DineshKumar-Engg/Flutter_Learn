import 'dart:convert';
import 'package:connect_athlete_admin/Config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class ClubsearchController extends GetConnect{
  String?service,token;
  RxList<dynamic>clubsearchdata=[].obs;

  Future<dynamic> ClubsearchApi(BuildContext context,sportid,state,city,publish,subscription)async{
    service=ApiConfig.service;

    final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var gettoken=sharedPreferences.getString('token');
    token=gettoken??'';

    final url=Uri.parse("$service/api/v1/getallacademies?page=1&limit=1000&city=$city&residentialState=$state&sportsId=$sportid&isSubscription=$subscription&isPublish=$publish");

    final header={
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Authorization':'$token'
    };

    final responce=await http.get(url,headers: header);

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      final value=(data['data']);
      clubsearchdata.assignAll([value]);
      return responce;
    }
    else{
      return responce;
    }
  }
}