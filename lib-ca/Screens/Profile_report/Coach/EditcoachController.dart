import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Config.dart';
import '../../../widget/Snackbar.dart';

class EditcoachController extends GetConnect{
  String?service,token;
  RxList<dynamic>editcoachdata=<dynamic>[].obs;
  Future<dynamic> EditCoachApi(BuildContext context,id,firstname,lastname,email,ageyoucoach,bio,city,state,genderyoucoach,iglink,xlink,approve,lookigfor,website,phone,publish,sportid,coachspeciality,issubscription)async{
    service=ApiConfig.service;

    final SharedPreferences shref=await SharedPreferences.getInstance();
    var gettoken=shref.getString('token');
    token=gettoken??'';

    String baseurl="${service}/api/v1/updatecoach";

    final url=Uri.parse(baseurl);

    final header={
      "Accept":"application/json",
      "Content-type":"application/json",
      "Authorization":'$token'
    };

    final json='{"id":"$id","firstName": "$firstname","lastName": "$lastname","email": "$email","ageYouCoach":"$ageyoucoach","bio":"$bio","city":"$city","genderYouCoach":"$genderyoucoach","instagramLink":"$iglink","isApprove":"$approve","lookingFor":"$lookigfor","profileImg":"","state":"$state","title":"","twitterLink":"$xlink","websiteLink":"$website","phone":"$phone","sportsId":"$sportid","isPublish":"$publish","coachSpecialty":"$coachspeciality","achievements":"","isSubscription":"$issubscription","isActive":"","age":""}';

    final responce=await http.post(url,headers: header,body: json.toString());

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      StackDialog.show("Updated Successfully.", "Coach Profile has been updated.", Icons.verified, Colors.green);
      final value=(data['data']);
      editcoachdata.assignAll(value);
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