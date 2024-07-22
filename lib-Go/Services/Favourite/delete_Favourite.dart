import 'package:connect_athelete/widget/Snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'package:connect_athelete/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Deletefavourite_Controller extends GetConnect{
  String?service;
  String token='';
  int?userid;
  RxList<dynamic> deletefavouritedata=<dynamic>[].obs;

  Future<dynamic>Deletefavourite_Api(BuildContext context,favouriteid)async{
    final SharedPreferences shref=await SharedPreferences.getInstance();

    var gettoken=shref.getString('token');
    token=gettoken??'';
    service=ApiConfig.service;

    final url=Uri.parse("$service/api/v1/favoritesremove");

    final header={
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Authorization':'$token'
    };

    final json='{"id":"$favouriteid"}';

    final responce=await http.post(url,headers: header,body: json.toString());
    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      StackDialog.show("Removed Successfully", "Favourite Removed Successfully", Icons.verified, Colors.green);
      final value=(data['data']);
      deletefavouritedata.assignAll(value);
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