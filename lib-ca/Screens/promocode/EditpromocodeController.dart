import 'dart:convert';
import 'package:connect_athlete_admin/Config.dart';
import 'package:connect_athlete_admin/Widget/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Getall_proocode_Controller.dart';

class EditpromocodeController extends GetConnect{

  String?service,token;
  RxList<dynamic> editpromocodedata=<dynamic>[].obs;
  final Getall_promocode_Controller getall_promocode_controller=Get.find<Getall_promocode_Controller>();

  Future<dynamic> EditPromocodeApi(BuildContext context,promocodename,description,start,end,discount,accesslimit,roleid,status,id)async{
    final SharedPreferences shref=await SharedPreferences.getInstance();
    var gettoken=shref.getString('token');
    token=gettoken??'';

    service=ApiConfig.service;

    final url=Uri.parse("$service/api/v1/updatepromocode");

    final header={
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Authorization':'$token'
    };

    final json='{"id":"$id","promocodeName":"$promocodename","promocodeDescription":"$description","startDate":"$start","endDate":"$end","discount":"$discount","accessLimit":"$accesslimit","roleId":"$roleid","isEnable":"$status"}';

    final responce=await http.post(url,headers: header,body: json.toString());

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      StackDialog.show("Successfully Updated", "Promocode Updated Successfully", Icons.verified, Colors.green);
      await getall_promocode_controller.GetPromocodeApi(context);
      // final value=(data['data']);
      // editpromocodedata.assignAll(value);
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