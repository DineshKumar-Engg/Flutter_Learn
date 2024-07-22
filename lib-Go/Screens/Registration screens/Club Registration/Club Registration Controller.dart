import 'dart:convert';
import 'package:connect_athelete/Config.dart';
import 'package:connect_athelete/Screens/Registration%20screens/Athlete%20Registration/Sucessscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import '../../../widget/Snackbar.dart';


class ClubRegisrationController extends GetConnect{
  String ?service;
  RxList<dynamic>clubsregistrationdata=<dynamic>[].obs;

  Future<dynamic> ClubregistrationApi(BuildContext context,organization,first,last,phone,sports,state,league,sportid,email,about,city) async{

    service=ApiConfig.service;

    final baseurl="${service}/api/v1/registeracademies";

    final url=Uri.parse(baseurl);

    final header={
      'Accept':'application/json',
      'Content-type':'application/json'
    };

    final json='{"firstName": "$first","lastName": "$last","email": "$email","password": "","profileImg": "","academieName": "$organization","title": "","bio": "$about","city": "$city","state": "$state","leagueName": "$league","instagramLink": "","twitterLink": "","websiteLink":"","ageYouCoach":"","genderYouCoach":"","sportsId": "$sportid","subscriptionId": "","phone":"$phone"}';

    final responce=await http.post(url,headers: header,body: json.toString());

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200) {
      Get.to(Sucessscreen());
      StackDialog.show("Connect Athlete", "Registration Successfully", Icons.verified, Colors.green);
      if (responce.statusCode == 200) {
        final value = (data['user']);
        clubsregistrationdata.assignAll(value);
      }
      else if (responce.statusCode == 409) {
        StackDialog.show("Connect Athlete", "User Already Exits", Icons.info, Colors.red);
      }
      else if (responce.statusCode == 500) {
        StackDialog.show("Connect Athlete", "Internal Server Error", Icons.info, Colors.red);
      }
      else {
        return responce;
      }
    }
  }
}