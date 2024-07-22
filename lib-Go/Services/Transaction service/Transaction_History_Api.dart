import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Config.dart';

class TransactionHistoryController extends GetConnect{

  String?service;
  int?userid;
  String usertoken='';
  RxList<dynamic>gettransactionhistorydata=[].obs;

  Future<dynamic> TransactionHistoryApi(BuildContext context)async{
    final SharedPreferences shref=await SharedPreferences.getInstance();
    var id=shref.getInt('userid');
    userid=(id??'') as int;

    var token=shref.getString('token');
    usertoken=token??'';
    service=ApiConfig.service;

    final baseurl="${service}/api/v1/transactionhistory/$userid";

    final url=Uri.parse(baseurl);

    final header={
      'Accept':'application/json',
      'Content-type':'application/json',
      'Authorization':"$usertoken"
    };

    final responce=await http.get(url,headers: header);

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      final value=(data['transactionData']);
      gettransactionhistorydata.assignAll(value);
      return responce;
    }
    else{
      return responce;
    }
  }
}