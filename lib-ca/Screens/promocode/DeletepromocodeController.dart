import 'dart:convert';
import 'package:connect_athlete_admin/Config.dart';
import 'package:connect_athlete_admin/Widget/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Getall_proocode_Controller.dart';

class DeletepromocodeController extends GetConnect{

  String?service,token;
  RxList<dynamic> deletepromocodedata=<dynamic>[].obs;
  final Getall_promocode_Controller getall_promocode_controller=Get.find<Getall_promocode_Controller>();

  Future<dynamic> DeletePromocodeApi(BuildContext context,id)async{
    final SharedPreferences shref=await SharedPreferences.getInstance();
    var gettoken=shref.getString('token');
    token=gettoken??'';

    service=ApiConfig.service;

    final url=Uri.parse("$service/api/v1/deletepromocode/$id");

    final header={
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Authorization':'$token'
    };


    final responce=await http.post(url,headers: header);

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      StackDialog.show("Successfully Deleted", "Promocode Deleted Successfully", Icons.verified, Colors.green);
      await getall_promocode_controller.GetPromocodeApi(context);

      // final value=(data['data']);
      // deletepromocodedata.assignAll(value);
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