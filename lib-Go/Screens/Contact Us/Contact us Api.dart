import 'dart:convert';
import 'package:connect_athelete/Config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../widget/Snackbar.dart';

class ContactUscontroller extends GetConnect{
  String ?service;
  RxList<dynamic>contactdata=<dynamic>[].obs;

  Future<dynamic>ContactusApi(BuildContext context,firstname,lastname,email,phone,message)async{

    service=ApiConfig.service;

    final baseurl="${service}/api/v1/addcontacts";

    final url=Uri.parse(baseurl);

    final header={
      'Accept':'application/json',
      'Content-type':'appication/json',
    };
    final json='{"firstname": "$firstname","lastname": "$lastname","phone": "$phone","email": "$email","message": "$message"}';
    // final json='{"firstname": "sfjhsf","lastname": "abvbj","phone": "9898989898","email": "hgf@gmail.com","message": "skdjvsvdjvjk"}';

    final responce=await http.post(url,headers: header,body: json.toString());

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      StackDialog.show("ThankYou", "We Contact You Shortly", Icons.verified, Colors.green);
    }
    else if(responce.statusCode==500){
      StackDialog.show("Server Error", "Internal Server Error", Icons.info, Colors.red);

    }
    else{
      return responce;
    }

  }
}
