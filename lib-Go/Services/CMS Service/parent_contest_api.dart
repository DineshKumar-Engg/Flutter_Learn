import 'dart:convert';

import 'package:connect_athelete/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;

class CMSParentcontestController extends GetConnect {
  String ?service;
  RxList<dynamic>cmsparentcontestdata = <dynamic>[].obs;


  Future<dynamic> cmsparentcontestapi(BuildContext context) async {
    service = ApiConfig.service;
    final baseurl = "$service/api/v1/getpage/6";

    final url = Uri.parse(baseurl);

    final responce = await http.get(url);

    final data = jsonDecode(responce.body);

    if (responce.statusCode == 200) {
      final value = (data['data']);
      cmsparentcontestdata.assignAll([value]);
      return responce;
    }
    else {
      return responce;
    }
  }
}