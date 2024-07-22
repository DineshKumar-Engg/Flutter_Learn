import 'dart:convert';

import 'package:connect_athelete/Config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';


class GetSubscriptionByid extends GetConnect{

  String?service;
  RxList<dynamic>getsubscriptiondata=<dynamic>[].obs;
  String ?gettoken;

  Future<dynamic> GetSubscriptionApi(BuildContext context,subscriptionid)async{

    final sharef=await SharedPreferences.getInstance();
    var token=sharef.getString("token");
    gettoken=token??'';
    service=ApiConfig.service;

    final baseurl="${service}/api/v1/getsubscription/$subscriptionid/";

    final url=Uri.parse(baseurl);

    final header={
      "Accept":"application/json",
      "Content-Type":"application/json",
      "Authorization":"$gettoken"
    };

    final responce=await http.get(url,headers: header);

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      final value=(data['data']);
      getsubscriptiondata.assignAll([value]);
      return responce;
    }
    else{
      return responce;
    }

  }
}