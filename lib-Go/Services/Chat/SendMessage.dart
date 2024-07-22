import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Config.dart';

class SendMessageController extends GetConnect {
  String? service;
  int? userid, roleid;

  Future<dynamic> SendMessageApi(BuildContext context, int receiverid, String message) async {
    service = ApiConfig.service;

    final SharedPreferences shref = await SharedPreferences.getInstance();
    userid = shref.getInt('userid') ?? 0;
    roleid = shref.getInt('roleid') ?? 0;

    final url = Uri.parse("$service/send");

    final header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };

    final json = jsonEncode({
      'roleId': roleid,
      'senderId': userid,
      'receiverId': receiverid,
      'content': message,
      'room':'$userid-$receiverid'
    });

    final response = await http.post(url, headers: header, body: json);

    if (response.statusCode == 200) {
      return response;
    } else {
      return response;
    }
  }
}
