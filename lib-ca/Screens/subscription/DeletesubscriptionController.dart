import 'dart:convert';
import 'package:connect_athlete_admin/Config.dart';
import 'package:connect_athlete_admin/Widget/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Getall_subscription_Controller.dart';

class DeletesubscriptionController extends GetConnect{

  String?service,token;
  RxList<dynamic> deletesubscriptiondata=<dynamic>[].obs;
  final Getall_subscription_Controller getall_subscription_controller=Get.find<Getall_subscription_Controller>();


  Future<dynamic> DeleteSubscriptionApi(BuildContext context,id)async{
    final SharedPreferences shref=await SharedPreferences.getInstance();
    var gettoken=shref.getString('token');
    token=gettoken??'';

    service=ApiConfig.service;

    final url=Uri.parse("$service/api/v1/deletesubscription/$id");

    final header={
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Authorization':'$token'
    };


    final responce=await http.post(url,headers: header);

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      StackDialog.show("Successfully Deleted", "Subscription Deleted Successfully", Icons.verified, Colors.green);
      await getall_subscription_controller.GetSubscripionApi(context);

      // final value=(data['data']);
      // deletesubscriptiondata.assignAll(value);
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