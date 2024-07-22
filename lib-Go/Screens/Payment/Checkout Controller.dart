import 'dart:convert';
import 'package:connect_athelete/Config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutController extends GetConnect{
  String ?service;
  String?gettoken;
  RxList <dynamic>checkoutdata=<dynamic>[].obs;

  Future<dynamic> CheckoutApi(BuildContext context,stateid)async{

    final shref=await SharedPreferences.getInstance();
    var token=shref.getString("token");
    gettoken=token??'';

    service=ApiConfig.service;

    final baseurl="${service}/api/v1/getbillingstate/$stateid/";

    final url=Uri.parse(baseurl);
    final header={
      "Accept":"application/json",
      "Content-Type":"application/json",
      "Authorization":"$gettoken"
    };

    final responce=await http.get(url,headers: header);

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      print(data);
      final value=(data['data']);
      checkoutdata.assignAll([value]);
      return responce;
    }
    else{
      return responce;
    }
  }

}