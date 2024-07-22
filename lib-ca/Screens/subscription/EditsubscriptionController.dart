import 'dart:convert';
import 'package:connect_athlete_admin/Config.dart';
import 'package:connect_athlete_admin/Widget/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Getall_subscription_Controller.dart';

class EditsubscriptionController extends GetConnect{

  String?service,token;
  RxList<dynamic> editsubscriptiondata=<dynamic>[].obs;
  final Getall_subscription_Controller getall_subscription_controller=Get.find<Getall_subscription_Controller>();


  Future<dynamic> EditSubscriptionApi(BuildContext context,planname,profile,limit,duration,amount,processing,convenience,servicenew,description,status,id)async{
    final SharedPreferences shref=await SharedPreferences.getInstance();
    var gettoken=shref.getString('token');
    token=gettoken??'';

    service=ApiConfig.service;

    final url=Uri.parse("$service/api/v1/updatesubscription");

    final header={
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Authorization':'$token'
    };

    final json='{"id":"$id","subscriptionName":"$planname","roleId":"$profile","subscriptionLimit":"$limit","subscriptionMonth":"$duration","subscriptionAmount":"$amount","processingTax":"$processing","convenienceTax":"$convenience","serviceTax":"$servicenew","description":"$description","subscribtionStatus":"$status"}';

    final responce=await http.post(url,headers: header,body: json.toString());

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      StackDialog.show("Successfully Updated", "Subscription Updated Successfully", Icons.verified, Colors.green);
      await getall_subscription_controller.GetSubscripionApi(context);

      // final value=(data['data']);
      // editsubscriptiondata.assignAll(value);
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