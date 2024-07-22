import 'dart:convert';
import 'package:connect_athelete/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class CoachProfileController extends GetConnect {
  String ?service;
  int?userid;
  String ?usertoken;

  RxList<dynamic>coachprofiledata = <dynamic>[].obs;
  RxList<dynamic>coachstatedata = <dynamic>[].obs;
  RxList<dynamic>coachcitydata = <dynamic>[].obs;
  RxList<dynamic>coachspecialitydata = <dynamic>[].obs;
  RxList<dynamic>coachsportdata = <dynamic>[].obs;

  Future<dynamic> CoachProfileApi(BuildContext context) async {
    final SharedPreferences shref = await SharedPreferences.getInstance();
    var id = shref.getInt('userid');
    userid = (id ?? '') as int;

    var token = shref.getString('token');
    usertoken = token ?? '';
    service = ApiConfig.service;
    final baseurl = "${service}/api/v1/getcoach/$userid/";
    final url = Uri.parse(baseurl);

    final header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': '$usertoken'
    };

    final response = await http.get(url, headers: header);

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final value = (data['data']);
      coachprofiledata.assignAll([value]);

      final value4 = (data['data']['stateData']);
      coachstatedata.assignAll(value4);

      final value1 = (data['data']['citiesData']);
      coachcitydata.assignAll(value1);

      final value2 = (data['data']['specialityData']);
      coachspecialitydata.assignAll(value2);

      final value3 = (data['data']['sportData']);
      coachsportdata.assignAll(value3);

      return response;
    }
    else {
      return response;
    }
  }
}