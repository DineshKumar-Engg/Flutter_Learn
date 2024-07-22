import 'dart:convert';
import 'package:connect_athlete_admin/Screens/Profile_report/Coach/GetallCoachController.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Config.dart';
import '../../../Widget/snackbar.dart';


class CoachRegistrationApi extends GetConnect{
  String ?service,token;
  RxList<dynamic>coachregistrationdata=[].obs;
  final GetallCoachController getallCoachController=Get.find<GetallCoachController>();

  Future<dynamic>coachregistrtionapi(BuildContext context,firstname,lastname,email,city,state,sportid,bio,phone,websitelink,ageyoucoach,genderyoucoach,lookingfor,iglink,xlink)async{
    service=ApiConfig.service;

    final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var gettoken=sharedPreferences.getString('token');
    token=gettoken??'';

    String baseurl="${service}/api/v1/admin-addcoach";

    final url=Uri.parse(baseurl);

    final header = {
      "Accept": "application/json",
      "Content-type": "application/json",
      "Authorization":'$token'
    };

    final json = '{"firstName": "$firstname","lastName": "$lastname","email": "$email","password": "","profileImg": "","age": 0,"gender": "","bio": "$bio","city": "$city","achievements": "","state": "$state","instagramLink": "$iglink","twitterLink": "$xlink","websiteLink":"$websitelink","coachSpecialty":"","ageYouCoach":"$ageyoucoach","genderYouCoach":"$genderyoucoach","sportsId": $sportid,"phone":"$phone","lookingFor":"$lookingfor"}';
    final responce = await http.post(url, headers: header, body: json.toString());
    final data = jsonDecode(responce.body);

    if(responce.statusCode==200){
      StackDialog.show("Connect Athlete", "Registration Successfully", Icons.verified, Colors.green);
      // final value=data(data['data']);
      // coachregistrationdata.assignAll(value);
      await getallCoachController.GetallcoachApi(context);

    }
    else if(responce.statusCode==409){
      StackDialog.show("Connect Athlete", "User Already Exits", Icons.info, Colors.red);
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