import 'dart:convert';
import '../../../Config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../widget/Snackbar.dart';

class Changepasswordcontroller extends GetConnect{
  String ?service;
  RxList<dynamic>changepassworddata=<dynamic>[].obs;
  String token='';

  Future <dynamic>changepasswordapi(BuildContext context,oldpassword,newpassword,route)async{
    final SharedPreferences shref=await SharedPreferences.getInstance();
     var gettoken=shref.getString('token');
     token=gettoken??'';
    service=ApiConfig.service;
    final baseurl="${service}/api/v1/changepassword";
    final url=Uri.parse(baseurl);

    final header={
      'Accept':'application/json',
      'Content-type':'application/json',
      'Authorization':'$token'
    };
    print(token);

    final json='{"oldpassword": "$oldpassword","newpassword": "$newpassword"}';

    final responce=await http.post(url,headers: header,body: json.toString());

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      print(token);
      StackDialog.show("Successfully Changed", "Password Successfully Changed", Icons.verified, Colors.green);
      final value=(data['data']);
      changepassworddata.assignAll(value);
      return responce;

    }
    else if(responce.statusCode==401){
      StackDialog.show("Required Field is Empty", "Enter Valid Old Password", Icons.info, Colors.red);
      return responce;
    }
    else{
      return null;
    }

  }

}