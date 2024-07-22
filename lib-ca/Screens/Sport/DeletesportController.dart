import 'dart:convert';
import 'package:connect_athlete_admin/Config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Widget/snackbar.dart';
import 'Getall_sport_Controller.dart';

class Deletesporcontroller extends GetConnect{

  String?service,token;
  RxList<dynamic> deletesportdata=<dynamic>[].obs;
  final Getall_sport_Controller getall_sport_controller=Get.find<Getall_sport_Controller>();


  Future<dynamic> DeleteSportApi(BuildContext context,sportid)async{
    final SharedPreferences shref=await SharedPreferences.getInstance();
    var gettoken=shref.getString('token');
    token=gettoken??'';

    service=ApiConfig.service;

    final url=Uri.parse("$service/api/v1/deletesport/$sportid");

    final header={
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Authorization':'$token'
    };


    final responce=await http.post(url,headers: header);

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      StackDialog.show("Sport Deleted", "Successfully Sport Deleted", Icons.verified, Colors.green);
      await getall_sport_controller.GetSportApi(context);

      // final value=(data['data']);
      // deletesportdata.assignAll(value);
      // return responce;
    }
    else if(responce.statusCode==500){
      StackDialog.show("Server Error", "Internal Server Error", Icons.info, Colors.red);
    }
    else{
      return responce;
    }

  }
}