import 'dart:convert';
import 'package:connect_athlete_admin/Config.dart';
import 'package:connect_athlete_admin/Widget/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class ClubpublishController extends GetConnect{

  String?service,token;
  RxList<dynamic> clubpublishdata=<dynamic>[].obs;

  Future<dynamic> ClubpublishApi(BuildContext context,id,publishstatus)async{
    final SharedPreferences shref=await SharedPreferences.getInstance();
    var gettoken=shref.getString('token');
    token=gettoken??'';

    service=ApiConfig.service;

    final url=Uri.parse("$service/api/v1/academieispublish/$id");

    final header={
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Authorization':'$token'
    };

    final json='{"isPublish":"$publishstatus"}';

    final responce=await http.post(url,headers: header,body: json.toString());

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      StackDialog.show("Successfully Updated", "Academie Profile Status Updated", Icons.verified, Colors.green);
      final value=(data['data']);
      clubpublishdata.assignAll(value);
      return responce;
    }
    else if(responce.statusCode==409){
      StackDialog.show("Payment Not Completed", "You Can't Publish this Profile.", Icons.info, Colors.red);
    }
    else if(responce.statusCode==500){
      StackDialog.show("Server Error", "Internal Server Error", Icons.info, Colors.red);
    }
    else{
      return responce;
    }

  }
}