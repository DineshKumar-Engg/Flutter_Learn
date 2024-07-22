import 'dart:convert';
import 'package:connect_athelete/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class ClubProfileDetailsController extends GetConnect{
  String ?service;
  RxList<dynamic>clunprofiledata=<dynamic>[].obs;
  RxList<dynamic>clubstatedata=<dynamic>[].obs;
  RxList<dynamic>clubcitydata=<dynamic>[].obs;
  RxList<dynamic>clubspecialitydata=<dynamic>[].obs;
  RxList<dynamic>clubsportdata=<dynamic>[].obs;
  String token='';
  int ?userid;
  Future<dynamic>ClubProfileDetailsApi(BuildContext context)async{

    service=ApiConfig.service;
    final SharedPreferences shref=await SharedPreferences.getInstance();
    var gettaken=shref.getString('token');
    token=gettaken??'';

    var id=shref.getInt('userid');
    userid=(id??'') as int;

    final String baseurl="${service}/api/v1/getacademies/$userid";

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
      clunprofiledata.assignAll([value]);

      final value1=(data['data']['stateData']);
      clubstatedata.assignAll(value1);

      final value2=(data['data']['citiesData']);
      clubcitydata.assignAll(value2);

      final value3=(data['data']['sportData']);
      clubsportdata.assignAll(value3);

      final value4=(data['data']['sportData']);
      clubspecialitydata.assignAll(value4);

      return responce;
    }
    else{
      return null;
    }

  }
}