import 'dart:convert';
import 'package:connect_athelete/Config.dart';
import 'package:connect_athelete/widget/Snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class Favourite_add_Controller extends GetConnect{
  String?service;
  int?userid;
  String?token;
  RxList<dynamic>favouriteadddata=<dynamic>[].obs;
  Future<dynamic>Favourite_Api(BuildContext context,favouriteid,roleid)async{

    final SharedPreferences shref=await SharedPreferences.getInstance();
    var getuserid=shref.getInt('userid');
    userid=getuserid??0;

    var gettoken=shref.getString('token');
    token=gettoken??'';

    service=ApiConfig.service;

    final baseurl="$service/api/v1/favoritesadd";

    final url=Uri.parse(baseurl);

    final header={
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Authorization':'$token'
    };

    final json='{"userId":"$userid","favoritesId":"$favouriteid","roleId":"$roleid"}';

    final responce=await http.post(url,headers: header,body: json.toString());

    final data=jsonDecode(responce.body);

    if(responce.statusCode==201){
      StackDialog.show("Favourite Added", "Favourite Added Successfully", Icons.verified, Colors.green);
      final value=(data['data']);
      favouriteadddata.assignAll(value);
      return responce;
    }
    else if(responce.statusCode==401){
      StackDialog.show("Already Added", "Favourite Already Added", Icons.info, Colors.red);
    }
    else if(responce.statusCode==500){
      StackDialog.show("Server Error", "Internal Server Error", Icons.info, Colors.red);
    }
    else{
      return responce;
    }

  }
}