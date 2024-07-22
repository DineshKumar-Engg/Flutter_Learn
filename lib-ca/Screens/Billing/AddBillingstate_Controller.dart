import 'dart:convert';
import 'package:connect_athlete_admin/Config.dart';
import 'package:connect_athlete_admin/Widget/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Getall_Billing_Controller.dart';

class AddbillingstateController extends GetConnect{

  String?service,token;
  RxList<dynamic> addbillingstatedata=<dynamic>[].obs;
  final Getall_Billing_Controller getall_billing_controller=Get.find<Getall_Billing_Controller>();


  Future<dynamic> AddBillingstateApi(BuildContext context,statename,tax)async{
    final SharedPreferences shref=await SharedPreferences.getInstance();
    var gettoken=shref.getString('token');
    token=gettoken??'';

    service=ApiConfig.service;

    final url=Uri.parse("$service/api/v1/addbillingstate");

    final header={
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Authorization':'$token'
    };

    final json='{"stateName":"$statename","tax":"$tax"}';

    final responce=await http.post(url,headers: header,body: json.toString());

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      StackDialog.show("Successfully Added", "New Billing State Added", Icons.verified, Colors.green);
      await getall_billing_controller.GetbillingstateApi(context);

      // final value=(data['data']);
      // addbillingstatedata.assignAll(value);
      // return responce;
    }
    else if(responce.statusCode==409){
      StackDialog.show("Already Exists", "Billing State with same name Exists", Icons.info, Colors.red);
    }
    else if(responce.statusCode==500){
      StackDialog.show("Server Error", "Internal Server Error", Icons.info, Colors.red);
    }
    else{
      return responce;
    }

  }
}