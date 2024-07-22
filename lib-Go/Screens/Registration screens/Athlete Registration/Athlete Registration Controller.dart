import 'dart:convert';
import 'package:connect_athelete/Config.dart';
import 'package:connect_athelete/Screens/Registration%20screens/Athlete%20Registration/Sucessscreen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import '../../../widget/Snackbar.dart';

class AthleteRegistrationApi extends GetConnect{
  String?service;
  RxList<dynamic>athleteredistrationdata=<dynamic>[].obs;
  Future<dynamic> athleteregistrationapi(BuildContext context,firstname,lastname,age,gender,school,city,state,parenfirst,parentlast,email,phone,game,sportid,grade)async{
    service=ApiConfig.service;

    String baseurl="${service}/api/v1/registerathlete";

    final url=Uri.parse(baseurl);

    final header={
      "Accept":"application/json",
      "Content-type":"application/json"
    };

    final json='{"firstName": "$firstname","lastName": "$lastname","email": "$email","password": "","profileImg": "","age": "$age","gender": "$gender","city": "$city","residentialState": "$state","school": "$school","bio": "","achievements": "","parentFirstName": "$parenfirst","parentLastName": "$parentlast","parentEmail": "","parentPhone": "$phone","parentConsent": true,"instagramLink": "","twitterLink": "","athleteSpecialty":"","currentAcademie":"","sportsId": "$sportid","subscriptionId": 0,"grade":"$grade"}';

    final responce=await http.post(url,headers: header,body: json.toString());

    final data=jsonDecode(responce.body);

    if (responce.statusCode == 201){
      StackDialog.show("Connect Athlete", "Registration Successfully", Icons.verified, Colors.green);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Sucessscreen()));
      final value = (data['data']);
      athleteredistrationdata.assignAll(value);
      return responce;
    } else if (responce.statusCode == 409) {
      StackDialog.show("Connect Athlete", "User Already Exists", Icons.info, Colors.red);
    } else if (responce.statusCode == 500) {
      StackDialog.show("Connect Athlete", "Internal Server Error", Icons.info, Colors.red);
    } else {
      StackDialog.show("Connect Athlete", "Registration Failed", Icons.error, Colors.red);
      return responce;
    }
  }
}