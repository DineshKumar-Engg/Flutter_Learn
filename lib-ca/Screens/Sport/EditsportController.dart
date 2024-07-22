import 'dart:convert';
import 'package:connect_athlete_admin/Config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Widget/snackbar.dart';
import 'Getall_sport_Controller.dart';

class Editsporcontroller extends GetConnect{

  String?service,token;
  RxList<dynamic> editsportdata=<dynamic>[].obs;
  final Getall_sport_Controller getall_sport_controller=Get.find<Getall_sport_Controller>();


  Future<dynamic> EditSportApi(BuildContext context,sportname,description,sportid)async{
    final SharedPreferences shref=await SharedPreferences.getInstance();
    var gettoken=shref.getString('token');
    token=gettoken??'';

    service=ApiConfig.service;

    final url=Uri.parse("$service/api/v1/updatesport");

    final header={
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Authorization':'$token'
    };

    final json='{"id":"$sportid","isActive":"true","sportName":"$sportname","sportDescription":"$description","sportLogo":""}';

    final responce=await http.post(url,headers: header,body: json.toString());

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      StackDialog.show("Sport Updated", "Successfully Sport Updated", Icons.verified, Colors.green);
      await getall_sport_controller.GetSportApi(context);

      // final value=(data['data']);
      // editsportdata.assignAll(value);
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