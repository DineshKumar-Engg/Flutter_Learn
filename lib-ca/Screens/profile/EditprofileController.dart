import 'dart:convert';
import 'package:connect_athlete_admin/Config.dart';
import 'package:connect_athlete_admin/Widget/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditprofileController extends GetConnect{

  String?service,token;
  RxList<dynamic> editprofiledata=<dynamic>[].obs;

  Future<dynamic> EditprofileApi(BuildContext context,firstname,lastname,email)async{
    final SharedPreferences shref=await SharedPreferences.getInstance();
    var gettoken=shref.getString('token');
    token=gettoken??'';

    service=ApiConfig.service;

    final url=Uri.parse("$service/api/v1/editadmin");

    final header={
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Authorization':'$token'
    };

    final json='{"firstName":"$firstname","lastName":"$lastname","profileImg":"","email":"$email"}';

    final responce=await http.post(url,headers: header,body: json.toString());

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      StackDialog.show("Successfully Updated", "Profile Details Updated.", Icons.verified, Colors.green);
      final value=(data['data']);
      editprofiledata.assignAll(value);
      return responce;
    }
    else if(responce.statusCode==500){
      StackDialog.show("Server Error", "Internal Server Error", Icons.info, Colors.red);
    }
    else{
      return responce;
    }

  }
}