import 'dart:convert';
import 'package:connect_athlete_admin/Config.dart';
import 'package:connect_athlete_admin/Widget/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Getspeciality_Controller.dart';

class deletespeciality_Controller extends GetConnect{

  String?service,token;
  RxList<dynamic> deletespecialitydata=<dynamic>[].obs;
  final Getspeciality_Controller getspeciality_controller=Get.find<Getspeciality_Controller>();


  Future<dynamic> DeleteSpecialityApi(BuildContext context,specialityid)async{
    final SharedPreferences shref=await SharedPreferences.getInstance();
    var gettoken=shref.getString('token');
    token=gettoken??'';

    service=ApiConfig.service;

    final url=Uri.parse("$service/api/v1/deletespeciality/$specialityid");

    final header={
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Authorization':'$token'
    };

    final responce=await http.delete(url,headers: header);

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      StackDialog.show("Successfully Deleted", " Speciality Deleted", Icons.verified, Colors.green);
      await getspeciality_controller.GetspecialityApi(context);
      // final value=(data['data']);
      // deletespecialitydata.assignAll(value);
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