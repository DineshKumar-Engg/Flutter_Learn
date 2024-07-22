import 'dart:convert';
import 'package:connect_athlete_admin/Screens/Profile_report/Club/GetallClubController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Config.dart';
import '../../../widget/Snackbar.dart';


class ClubRegisrationController extends GetConnect{
  String ?service,token;
  RxList<dynamic>clubsregistrationdata=<dynamic>[].obs;
  final GetallClubController getallClubController=Get.find<GetallClubController>();

  Future<dynamic> ClubregistrationApi(BuildContext context,organization,first,last,phone,state,league,sportid,email,about,city,ageyoucoach,genderyoucoach,xlink,iglink,websitelink) async{
    final SharedPreferences shref=await SharedPreferences.getInstance();
    var gettoken=shref.getString('token');
    token=gettoken??'';
    service=ApiConfig.service;

    final baseurl="${service}/api/v1/admin-addacademies";

    final url=Uri.parse(baseurl);

    final header={
      'Accept':'application/json',
      'Content-type':'application/json',
      'Authorization':'$token'
    };

    final json='{"firstName": "$first","lastName": "$last","email": "$email","password": "","profileImg": "","academieName": "$organization","title": "","bio": "$about","city": "$city","state": "$state","leagueName": "$league","instagramLink": "$iglink","twitterLink": "$xlink","websiteLink":"$websitelink","ageYouCoach":"$ageyoucoach","genderYouCoach":"$genderyoucoach","sportsId": "$sportid","subscriptionId": "","phone":"$phone"}';

    final responce=await http.post(url,headers: header,body: json.toString());

    final data=jsonDecode(responce.body);

    if(responce.statusCode==201) {
      StackDialog.show(
          "Registration Successfully", "Club & Academic Added", Icons.verified, Colors.green);
      await getallClubController.GetallclubApi(context);
      // if (responce.statusCode == 200) {
      //   final value = (data['user']);
      //   clubsregistrationdata.assignAll(value);
      // }
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
