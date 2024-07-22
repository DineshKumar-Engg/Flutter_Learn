import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Config.dart';
import '../../../widget/Snackbar.dart';

class EditclubController extends GetConnect{
  String?service,token;
  RxList<dynamic>editclubdata=<dynamic>[].obs;
  Future<dynamic> EditClubApi(BuildContext context,id,academicname,firstname,lastname,email,state,city,ageyoucoach,genderyoucoach,bio,website,xlink,iglink,phone,league,sportid,publish,subscriptionid,approve)async{
    service=ApiConfig.service;

    final SharedPreferences shref=await SharedPreferences.getInstance();
    var gettoken=shref.getString('token');
    token=gettoken??'';

    String baseurl="${service}/api/v1/updateacademies";

    final url=Uri.parse(baseurl);

    final header={
      "Accept":"application/json",
      "Content-type":"application/json",
      "Authorization":'$token'
    };

    final json='{"id":"$id","academieName":"$academicname","firstName": "$firstname","lastName": "$lastname","email": "$email","ageYouCoach":"$ageyoucoach","bio":"$bio","city":"$city","genderYouCoach":"$genderyoucoach","instagramLink":"$iglink","isApprove":"$approve","leagueName":"$league","profileImg":"","state":"$state","subscriptionId":"$subscriptionid","title":"","twitterLink":"$xlink","websiteLink":"$website","phone":"$phone","sportsId":"$sportid","isPublish":"$publish"}';

    final responce=await http.post(url,headers: header,body: json.toString());

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      StackDialog.show("Updated Successfully.", "Club & Academic Profile has been updated.", Icons.verified, Colors.green);
      final value=(data['data']);
      editclubdata.assignAll(value);
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