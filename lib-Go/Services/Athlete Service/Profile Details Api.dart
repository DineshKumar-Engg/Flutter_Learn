import 'dart:convert';
import 'package:connect_athelete/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfiledetailsController extends GetConnect {
  String ?service;
  int?userid;
  String token = '';

  RxList<dynamic>profiledata = <dynamic>[].obs;
  RxList<dynamic>specialitydata = <dynamic>[].obs;
  RxList<dynamic>sportdata=<dynamic>[].obs;


  Future<dynamic> ProfiledetailsApi(BuildContext context) async {
    service = ApiConfig.service;
    final SharedPreferences shref = await SharedPreferences.getInstance();
    var id = shref.getInt('userid');
    userid = (id ?? '') as int;
    var gettoken = shref.getString('token');
    token = gettoken ?? '';

    final baseurl = "${service}/api/v1/getathlete/$userid/";
    print(baseurl);

    final url = Uri.parse(baseurl);

    final header = {
      'Accept': 'application/json',
      'Content-type': 'application/json',
      'Authorization': '$token'
    };

    final responce = await http.get(url, headers: header);

    final data = jsonDecode(responce.body);
    if (responce.statusCode == 200) {
      final value = data['data'];
      profiledata.assignAll([value]);

      final value1 = (data['data']['specialityData']);
      specialitydata.assignAll(value1);

      final value2 = (data['data']['sportData']);
      sportdata.assignAll(value2);

      return responce;
    }
      else {
        return responce;
      }
    }
  }

