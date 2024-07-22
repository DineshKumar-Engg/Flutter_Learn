import 'dart:convert';

import 'package:connect_athelete/Config.dart';
import 'package:connect_athelete/widget/Snackbar.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PromoCodeController extends GetConnect{
  String?service;
  String ?gettoken;
  RxList<dynamic>promocodedata=<dynamic>[].obs;

  Future<dynamic> PromocodeApi(BuildContext context,promocode)async{

    final shref=await SharedPreferences.getInstance();
    var token=shref.getString("token");
    gettoken=token??'';

    service=ApiConfig.service;

    final baseurl="${service}/api/v1/promocodeismatched";

    final url=Uri.parse(baseurl);

    final header={
    "Accept":"application/json",
    "Content-Type":"application/json",
    "Authorization":"$gettoken"
    };

    final json='{"promocodeName":"$promocode"}';

    final responce=await http.post(url,headers: header,body: json.toString());

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      StackDialog.show("Promo code Applied", "Promo code Applied Successfully", Icons.verified, Colors.green);
      final value=(data['existingPromocode']);
      promocodedata.assignAll([value]);
      return responce;
    }
    else if(responce.statusCode==400){
      StackDialog.show("Expired", "Promo code Expired", Icons.info, Colors.red);
    }
    else if(responce.statusCode==404){
      StackDialog.show("Not Found", "Promo code Not Found", Icons.info, Colors.red);
    }
    else if(responce.statusCode==500){
      StackDialog.show("Server Error", "Internal Server Error", Icons.info, Colors.red);
    }
    else{
      return responce;
    }
  }
}