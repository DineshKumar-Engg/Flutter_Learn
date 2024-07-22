import 'dart:convert';
import '../../../Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;

class Sportslistcontroller extends GetConnect{
  String ?service;
  RxList<dynamic>getsportsdata=<dynamic>[].obs;
  Future<dynamic>sportslistapi(BuildContext context)async{

    service=ApiConfig.service;

    final baseurl="${service}/api/v1/getallsports";

    final url=Uri.parse(baseurl);
    final responce=await http.get(url);

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      final value=(data['data']);
      getsportsdata.assignAll(value);
      return responce;
    }
    else{
      return responce;
    }

  }
}