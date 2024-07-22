import 'dart:convert';
import 'package:connect_athelete/Services/Coach%20Service/Coach%20Details%20Api.dart';

import '../../Config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../widget/Snackbar.dart';

class CoachEditProfileController extends GetConnect{
  String?service;
  RxList<dynamic>coacheditdata=<dynamic>[].obs;
  int?userid;
  String token='';
  final CoachProfileController coachProfileController=Get.find<CoachProfileController>();
  Future<dynamic>CoachEditProfileApi(BuildContext context,first,last,age,gender,city,state,email,
      phone,bio,xlink,iglink,youtube,sportid,isactive,issubscription,ispublish,
      isapprove,websitelink,coachspeciality,ageyoucoach,genderyoucoach,lookingfor)async{
    final SharedPreferences shref=await SharedPreferences.getInstance();
    var getid=shref.getInt('userid');
    userid=(getid??'') as int;

    var gettoken=shref.getString('token');
    token=gettoken??'';

    service=ApiConfig.service;

    final String baseurl="${service}/api/v1/updatecoach";

    final url=Uri.parse(baseurl);

    final header={
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Authorization':'$token'
    };
    final json='{"id": $userid,"firstName": "$first","lastName": "$last","email": "$email","profileImg": "","age": $age,"gender": "$gender","bio": "$bio","city": "$city","achievements": "","state": "$state","instagramLink": "$iglink","twitterLink": "$xlink","websiteLink": "$websitelink","ageYouCoach":"$ageyoucoach","genderYouCoach":"$genderyoucoach","coachSpecialty":"$coachspeciality","lookingFor":"$lookingfor","phone":"$phone","sportsId": "$sportid","isActive": $isactive,"isSubscription":"$issubscription","isPublish":$ispublish,"isApprove":"$isapprove"}';

    final responce=await http.post(url,headers: header,body: json.toString());

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      StackDialog.show("Connect Athlete", "Profile Updated Successfully", Icons.verified, Colors.green);
      await coachProfileController.CoachProfileApi(context);
      // final value=(data['data']);
      // coacheditdata.assignAll([value]);
      // return responce;
    }
    else{
      return responce;
    }
  }
}