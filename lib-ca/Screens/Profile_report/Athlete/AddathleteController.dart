import 'dart:convert';
import 'package:connect_athlete_admin/Screens/Profile_report/Athlete/GetallathleteController.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Config.dart';
import '../../../widget/Snackbar.dart';

class AthleteRegistrationApi extends GetConnect{
  String?service,token;
  RxList<dynamic>athleteredistrationdata=<dynamic>[].obs;
  final GetallAthleteController getallAthleteController=Get.find<GetallAthleteController>();

  Future<dynamic> athleteregistrationapi(BuildContext context,firstname,lastname,age,gender,school,city,state,parenfirst,parentlast,email,phone,sportid,grade,xlink,iglink,bio,achievemengt,currentacademy)async{
    service=ApiConfig.service;

    final SharedPreferences shref=await SharedPreferences.getInstance();
    var gettoken=shref.getString('token');
    token=gettoken??'';

    String baseurl="${service}/api/v1/admin-addathlete";

    final url=Uri.parse(baseurl);

    final header={
      "Accept":"application/json",
      "Content-type":"application/json",
      "Authorization":'$token'
    };

    final json='{"firstName": "$firstname","lastName": "$lastname","email": "$email","password": "","profileImg": "","age": "$age","gender": "$gender","city": "$city","residentialState": "$state","school": "$school","bio": "$bio","achievements": "$achievemengt","parentFirstName": "$parenfirst","parentLastName": "$parentlast","parentEmail": "","parentPhone": "$phone","parentConsent": true,"instagramLink": "$iglink","twitterLink": "$xlink","athleteSpecialty":"","currentAcademie":"$currentacademy","sportsId": "$sportid","subscriptionId": 0,"grade":"$grade"}';

    final responce=await http.post(url,headers: header,body: json.toString());

    final data=jsonDecode(responce.body);

    if(responce.statusCode==201){
      StackDialog.show("Registration Successfully Completed", "Athlete Added", Icons.verified, Colors.green);
      await getallAthleteController.GetallathleteApi(context);
      // final value=(data['data']);
      // athleteredistrationdata.assignAll(value);
      // return responce;
    }
    else if(responce.statusCode==409){
      StackDialog.show("Connect Athlete", "Athlete Already Exists", Icons.info, Colors.red);
    }
    else if(responce.statusCode==500){
      StackDialog.show("Connect Athlete", "Internal Server Error", Icons.info, Colors.red);
    }
    else{
      return null;
    }
    return responce;
  }
}