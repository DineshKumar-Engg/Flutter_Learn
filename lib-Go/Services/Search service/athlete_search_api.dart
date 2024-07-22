import 'dart:convert';
import 'package:connect_athelete/Config.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AthleteSearchController extends GetConnect {
  String?service;
  RxList<dynamic>athletesearchdata = <dynamic>[].obs;
  RxList<dynamic>athletesporthdata = <dynamic>[].obs;
  String?token;

  Future<dynamic> AthleteSearchApi(BuildContext context, sportidnew,stateid,cityid,age,gender) async {
    service = ApiConfig.service;

    final SharedPreferences shref = await SharedPreferences.getInstance();
    var gettoken = shref.getString("token");
    token = gettoken??'';

    final baseurl = "${service}/api/v1/coachsearchathlete?sportsId=$sportidnew&gender=$gender&city=$cityid&residentialState=$stateid&age=$age";

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
      athletesearchdata.assignAll(value);
      return responce;
    }
    else {
      return responce;
    }
  }
}