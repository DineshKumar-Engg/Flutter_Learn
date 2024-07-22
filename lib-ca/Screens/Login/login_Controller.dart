import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:connect_athlete_admin/Config.dart';
import 'package:connect_athlete_admin/Screens/Home/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Widget/snackbar.dart';

class login_Controller extends GetConnect{
  String?service;
  RxList<dynamic>logindata=<dynamic>[].obs;

  Future<http.Response?>loginApi(BuildContext context,email,password)async{
    service=ApiConfig.service;

    final url=Uri.parse("$service/api/v1/login");

    final header={
      'Accept':'application/json',
      'Content-Type':'application/json'
    };

    final json='{"email":"$email","password":"$password"}';

    final responce= await http.post(url,headers: header,body: json.toString());

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("token", data['token']);
      prefs.setInt("userid", data['user']['id']);
      prefs.setInt("sessionid",1);
      StackDialog.show("Connect Athlete", "Login Successfully", Icons.verified, Colors.green);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const home_screen()));
      final value=(data['data']);
      logindata.assignAll(value);
      return responce;
    }
    else if(responce.statusCode==400){
      StackDialog.show("Incorrect Password", "Enter the Valid Password", Icons.info, Colors.red);
    }
    else if(responce.statusCode==401){
      StackDialog.show("Connect Athlete", "User Not Found", Icons.info, Colors.red);
    }
    else if(responce.statusCode==500){
      StackDialog.show("Server Error", "Internal Server Error", Icons.info, Colors.red);
    }
    else{
      return responce;
    }
  }
}