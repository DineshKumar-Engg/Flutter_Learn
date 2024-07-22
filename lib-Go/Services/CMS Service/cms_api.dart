import 'dart:convert';

import 'package:connect_athelete/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;

class CMSController extends GetConnect {
  String ?service;
  RxList<dynamic>cmsdata = <dynamic>[].obs;
  RxList<dynamic>cmsgallery = <dynamic>[].obs;


  Future<dynamic> cmsapi(BuildContext context,cmsid) async {
    service = ApiConfig.service;
    final baseurl = "$service/api/v1/getpage/$cmsid";

    final url = Uri.parse(baseurl);

    final responce = await http.get(url);

    final data = jsonDecode(responce.body);

    if (responce.statusCode == 200) {
      final value = (data['data']['cmssections']);
      cmsdata.assignAll(value);

      if (responce.statusCode == 200) {
        final value1 = (data['data']['cmsgalleries']);
        cmsgallery.assignAll(value1);
        return responce;
      }
      else {
        return responce;
      }
    }
  }
}