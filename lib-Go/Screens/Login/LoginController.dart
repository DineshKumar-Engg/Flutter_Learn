import 'dart:convert';
import 'package:connect_athelete/Config.dart';
import 'package:connect_athelete/Screens/Athlete/Athlete%20Homescreen.dart';
import 'package:connect_athelete/Screens/Coach/Coach%20Homescreen.dart';
import 'package:connect_athelete/Screens/Login/Loginscreen.dart';
import 'package:connect_athelete/Screens/Subscription/Subscription.dart';
import 'package:connect_athelete/widget/Snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Club/Club Homescreen.dart';


class LoginApi extends GetConnect {
  String?service;
  RxList<dynamic>loginapidata = <dynamic>[].obs;
  Future <http.Response?>loginapi(BuildContext context,email,password) async {
    service=ApiConfig.service;

    String baseurl = "${service}/api/v1/login/";

    final url = Uri.parse(baseurl);

    final header = {
      "Accept": "application/json",
      "Content-type": "application/json"
    };

    final json = '{"email":"$email","password":"$password"}';

    final responce = await http.post(url, headers: header, body: json.toString());
    final data = jsonDecode(responce.body);

    if (responce.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
       prefs.setInt("userid", data['user']['id']);
      prefs.setString("token", data['token']);
      prefs.setInt("roleid", data['user']['roleId']);
       prefs.setString("sportid",data['profileData']['sportsId']);

      if(data['user']['roleId']==2 && data['profileData']['isSubscription']=='Active'){
        prefs.setString("sessionid","athlete");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const AthleteHomescreen()));
      }
      else if(data['user']['roleId']==2 && data['profileData']['isSubscription']=='Inactive'){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Subscriptionscreen()));
      }
      else if(data['user']['roleId']==2 && data['profileData']['isSubscription']=='Expired'){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Subscriptionscreen()));
      }
      else if(data['user']['roleId']==3 && data['profileData']['isSubscription']=='Active'){
        prefs.setString("sessionid", "coach");
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const CoachHomescreen()));
      }
      else if(data['user']['roleId']==3 && data['profileData']['isSubscription']=='Inactive'){
        prefs.setString("sessionid","coach");
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const Loginscreen()));
      }
      else if(data['user']['roleId']==4 && data['profileData']['isSubscription']=='Active'){
        prefs.setString("sessionid", "club");
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const ClubsHomescreen()));
      }
      else if(data['user']['roleId']==4 && data['profileData']['isSubscription']=='Inactive'){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Subscriptionscreen()));
      }
      else if(data['user']['roleId']==4 && data['profileData']['isSubscription']=='Expired'){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Subscriptionscreen()));
      }
      StackDialog.show("Connect Athlete", "Login Successfully", Icons.verified, Colors.green);
      final value=(data['user']);
      loginapidata.assignAll([value]);
      print("User successfully Logged in ");
    }
    else if(responce.statusCode==400){
      StackDialog.show("Connect Athlete", "Incorrect Password", Icons.info, Colors.red);
    }
    else if(responce.statusCode==401){
      StackDialog.show("Connect Athlete","User Not Found", Icons.info, Colors.red);
    }
    else if(responce.statusCode==500){
      StackDialog.show("Server Error", "Internal Server Error", Icons.info, Colors.red);
    }
    else{
      StackDialog.show("Internet Connection Error", "Please Check Your network Connections", Icons.info, Colors.red);
    }
    return responce;
  }
}