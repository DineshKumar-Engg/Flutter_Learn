import 'dart:convert';
import 'package:connect_athlete_admin/Config.dart';
import 'package:connect_athlete_admin/Widget/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class DeleteCoachController extends GetConnect{

  String?service,token;
  RxList<dynamic> deletecoachdata=<dynamic>[].obs;

  Future<dynamic> DeletecoachApi(BuildContext context,id)async{
    final SharedPreferences shref=await SharedPreferences.getInstance();
    var gettoken=shref.getString('token');
    token=gettoken??'';

    service=ApiConfig.service;

    final url=Uri.parse("$service/api/v1/deletecoach/$id");

    final header={
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Authorization':'$token'
    };

    final responce=await http.post(url,headers: header);


    if(responce.statusCode==200){
      StackDialog.show("Deleted Successfully", "Coach Profile Deleted", Icons.verified, Colors.green);
      return responce;
    }
    else{
      return responce;
    }

  }
}