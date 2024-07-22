import 'dart:convert';
import '../../Config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpecialitylistController extends GetConnect{
  String ?service;
  RxList<dynamic>specialitydata=<dynamic>[].obs;
  String?sportid;
  String?token;

  Future<dynamic>SpecialityApi(BuildContext context)async{
    service=ApiConfig.service;
    SharedPreferences shref=await SharedPreferences.getInstance();
    var id=shref.getString('sportid');
    sportid=id??"";

    var userdata=shref.getString('token');
    token=userdata??'';

    final baseurl="${service}/api/v1/getspecialitybysport?sportId=$sportid";

    final url=Uri.parse(baseurl);

    final header={
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Authorization':'$token'
    };

    final responce=await http.get(url,headers: header);

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      final value=(data['data']);
      specialitydata.assignAll(value);
      return responce;
    }
    else{
      return responce;
    }
  }
}