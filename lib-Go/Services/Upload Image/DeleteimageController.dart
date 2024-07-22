import 'dart:convert';
import 'package:connect_athelete/Config.dart';
import 'package:connect_athelete/Services/Athlete%20Service/Profile%20Details%20Api.dart';
import 'package:connect_athelete/widget/Snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class Deleteimagecontroller extends GetConnect{
  String?service,token;
  RxList<dynamic>deleteimagedata=<dynamic>[].obs;
  final ProfiledetailsController profiledetailsController=Get.find<ProfiledetailsController>();

  Future<dynamic> DeleteimageApi(BuildContext context,imageid)async{
    service=ApiConfig.service;

    final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var gettoken=sharedPreferences.getString('token');
    token=gettoken??'';

    final url=Uri.parse("$service/api/v1/delete-file/$imageid");

    final header={
      'Accept':'application/json',
      'Content-type':'application,json',
      'Authorization':'$token'
    };

    final responce=await http.post(url,headers: header);

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      StackDialog.show("Deleted Successfully", "Headshot Image Deleted Successfully", Icons.verified, Colors.green);
      await profiledetailsController.ProfiledetailsApi(context);
      // final value=(data['data']);
      // deleteimagedata.assignAll(value);
      // return responce;
    }
    else{
      return responce;
    }

  }


}