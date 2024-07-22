import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Config.dart';
import '../../../widget/Snackbar.dart';

class EditRegistrationController extends GetConnect{
  String?service,token;
  RxList<dynamic>editregistrationdata=<dynamic>[].obs;
  Future<dynamic> EditRegistrationApi(BuildContext context,id,firstname,lastname,age,gender,school,city,state,parenfirst,parentlast,email,phone,sportid,grade,xlink,iglink,bio,achievemengt,currentacademy,approve,publish,sunscription,active,speciality)async{
    service=ApiConfig.service;

    final SharedPreferences shref=await SharedPreferences.getInstance();
    var gettoken=shref.getString('token');
    token=gettoken??'';

    String baseurl="${service}/api/v1/updateathlete";

    final url=Uri.parse(baseurl);

    final header={
      "Accept":"application/json",
      "Content-type":"application/json",
      "Authorization":'$token'
    };

    final json='{"id":"$id","firstName": "$firstname","lastName": "$lastname","email": "$email","password": "","profileImg": "","age": "$age","gender": "$gender","city": "$city","residentialState": "$state","school": "$school","bio": "$bio","achievements": "$achievemengt","parentFirstName": "$parenfirst","parentLastName": "$parentlast","parentEmail": "","parentPhone": "$phone","parentConsent": true,"instagramLink": "$iglink","twitterLink": "$xlink","athleteSpecialty":"$speciality","currentAcademie":"$currentacademy","sportsId": "$sportid","subscriptionId": 0,"grade":"$grade","isApprove":"$approve","isPublish":"$publish","isSubscription":"$sunscription","isActive":"$active"}';

    final responce=await http.post(url,headers: header,body: json.toString());

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      StackDialog.show("Updated Successfully.", "Athlete Profile has been updated.", Icons.verified, Colors.green);
      final value=(data['data']);
      editregistrationdata.assignAll(value);
      return responce;
    }
    else if(responce.statusCode==500){
      StackDialog.show("Connect Athlete", "Internal Server Error", Icons.info, Colors.red);
    }
    else{
      return responce;
    }
    return responce;
  }
}