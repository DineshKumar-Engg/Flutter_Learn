import 'dart:convert';
import 'package:connect_athelete/Config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoachSearchController extends GetConnect {
  String?service;
  RxList<dynamic>coachsearchdata = <dynamic>[].obs;
  RxList<dynamic>coachgallerydata = <dynamic>[].obs;
  RxList<dynamic>coachstatedata = <dynamic>[].obs;
  RxList<dynamic>coachcitydata = <dynamic>[].obs;
  int?sportid;
  String?token;

  Future<dynamic> CoachSearchApi(BuildContext context, sportidnew,stateid,cityid) async {
    service = ApiConfig.service;

    final SharedPreferences shref = await SharedPreferences.getInstance();

    var gettoken = shref.getString("token");
    token = gettoken ?? '';

    final baseurl = "${service}/api/v1/athletesearchcoach?sportsId=$sportidnew&city=$cityid&state=$stateid";

    final url = Uri.parse(baseurl);

    final header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "$token"
    };

    final responce = await http.get(url, headers: header);

    final data = jsonDecode(responce.body);

    if (responce.statusCode == 200) {
      final value = (data['data']);
      coachsearchdata.assignAll(value);
      return responce;
    }
    if(responce.statusCode==200){
      final value=(data['data']['stateData']);
      coachstatedata.assignAll(value);
      return responce;
    }

    else {
      return responce;
    }
  }
}