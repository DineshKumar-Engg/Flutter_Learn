import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Config.dart';
import '../../widget/Snackbar.dart';

class ForgetPasswordController extends GetConnect{
  String?service;
  String?usertoken;
  RxList<dynamic>getforgetpassworddata=[].obs;

  Future<dynamic> ForgetPasswordApi(BuildContext context,email)async{
    final SharedPreferences shref=await SharedPreferences.getInstance();
    var token= shref.getString('token');
    usertoken=token??'';

    service=ApiConfig.service;

    final baseurl="${service}/api/v1/forgotpassword";

    final url=Uri.parse(baseurl);

    final header={
      'Accept':'application/json',
      'Content-type':'application/json',
      'Authorization':'$usertoken'
    };

    final json='{"email":"$email"}';

    final responce=await http.post(url,headers: header,body: json.toString());

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      StackDialog.show("Email Send Successfully", "You will receive an password.", Icons.verified, Colors.green);
      final value=(data['data']);
      getforgetpassworddata.assignAll(value);
      return responce;
    }
    else if(responce.statusCode==400){
      StackDialog.show("Connect Athlete", "EmailID doesn't Exit", Icons.info, Colors.red);
    }
    else{
      return responce;
    }

  }
}
