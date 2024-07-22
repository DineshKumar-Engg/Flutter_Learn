import 'dart:convert';
import 'package:connect_athlete_admin/Config.dart';
import 'package:connect_athlete_admin/Screens/Speciality/Getspeciality_Controller.dart';
import 'package:connect_athlete_admin/Widget/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
class Editspeciality_Controller extends GetConnect{

  String?service,token;
  RxList<dynamic> editspecialitydata=<dynamic>[].obs;
  final Getspeciality_Controller getspeciality_controller=Get.find<Getspeciality_Controller>();


  Future<dynamic> EditSpecialityApi(BuildContext context,title,sportid,specialityid)async{
    final SharedPreferences shref=await SharedPreferences.getInstance();
    var gettoken=shref.getString('token');
    token=gettoken??'';

    service=ApiConfig.service;

    final url=Uri.parse("$service/api/v1/editspeciality");

    final header={
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Authorization':'$token'
    };


    final json='{"id":"$specialityid","specialityTitle":"$title","sportId":"$sportid"}';

    final responce=await http.post(url,headers: header,body: json.toString());

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      StackDialog.show("Successfully Updated", "Speciality Edited", Icons.verified, Colors.green);
      await getspeciality_controller.GetspecialityApi(context);
      // final value=(data['data']);
      // editspecialitydata.assignAll(value);
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