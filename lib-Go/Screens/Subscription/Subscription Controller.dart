import 'dart:convert';
import 'package:connect_athelete/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class SubscriptionController extends GetConnect{
  String ?service;
  RxList<dynamic>subscriptiondata=<dynamic>[].obs;

  Future<dynamic>SubscriptionApi(BuildContext context)async{
    String token='';
    final SharedPreferences shref=await SharedPreferences.getInstance();
    var gettoken=shref.getString('token');
    token=gettoken??'';

    service=ApiConfig.service;

    final baseurl="${service}/api/v1/getallsubscriptions";

    final url=Uri.parse(baseurl);

    final header={
      'Accept':'application/json',
      'Content-type':'application/json',
      'Authorization':'$token'
    };

    final responce=await http.get(url,headers: header);

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      final value=(data['data']);
      print(data);
      subscriptiondata.assignAll(value);
      return responce;
    }
    else{
      return responce;
    }
  }
}