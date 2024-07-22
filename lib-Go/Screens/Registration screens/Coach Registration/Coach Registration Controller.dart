import 'dart:convert';
import 'package:connect_athelete/Config.dart';
import 'package:connect_athelete/widget/Snackbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';

import 'coach sucess.dart';
class CoachRegistrationApi extends GetConnect{
  String ?service;
  RxList<dynamic>coachregistrationdata=[].obs;

  Future<dynamic>coachregistrtionapi(BuildContext context,firstname,lastname,email,city,state,sportid,bio,phone,websitelink)async{
   service=ApiConfig.service;

   String baseurl="${service}/api/v1/registercoach/";

   final url=Uri.parse(baseurl);

   final header = {
     "Accept": "application/json",
     "Content-type": "application/json"
   };

   final json = '{"firstName": "$firstname","lastName": "$lastname","email": "$email","password": "","profileImg": "","age": 0,"gender": "","bio": "$bio","city": "$city","achievements": "","state": "$state","instagramLink": "","twitterLink": "","websiteLink":"$websitelink","coachSpecialty":"","ageYouCoach":"","genderYouCoach":"","sportsId": $sportid,"phone":"$phone","lookingFor":""}';
   final responce = await http.post(url, headers: header, body: json.toString());
   final data = jsonDecode(responce.body);

   if(responce.statusCode==200){
     Get.to(const Coachsucess());
     StackDialog.show("Connect Athlete", "Registration Successfully", Icons.verified, Colors.green);
     final value=data(data['Output']);
     coachregistrationdata.assignAll(value);
     return responce;
   }
   else if(responce.statusCode==409){
     StackDialog.show("Connect Athlete", "User Already Exits", Icons.info, Colors.red);
   }
   else if(responce.statusCode==500){
     StackDialog.show("Connect Athlete", "Internal Server Error", Icons.info, Colors.red);
   }
   else{
     return responce;
   }
  }
}