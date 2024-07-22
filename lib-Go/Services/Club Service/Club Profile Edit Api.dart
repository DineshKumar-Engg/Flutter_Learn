import 'dart:convert';
import 'package:connect_athelete/Services/Club%20Service/Club%20Details%20Api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../../Config.dart';
import '../../widget/Snackbar.dart';
class ClubProfileEditController extends GetConnect{
  String ?service;
  RxList<dynamic>clubeditprofiledata=[].obs;
  final ClubProfileDetailsController clubProfileDetailsController=Get.find<ClubProfileDetailsController>();
  String token='';
  int ?userid;
  Future<dynamic> ClubProfileEditApi(BuildContext context,organization,first,last,phone,about,laegue,flight,city,state,website,youtube,sportid,xlink,iglink,ageyouucoach,genderyoucoach,email)async{
    service=ApiConfig.service;
    final SharedPreferences shref=await SharedPreferences.getInstance();
    var gettaken=shref.getString('token');
    token=gettaken??'';

    var id=shref.getInt('userid');
    userid=(id??'') as int;

    final String baseurl="${service}/api/v1/updateacademies";

    final url=Uri.parse(baseurl);

    final header={
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Authorization':'$token'
    };

    final json='{"id": $userid,"firstName": "$first","phone":"$phone","ageyoucoach":"$ageyouucoach","ageyougender":"$genderyoucoach","lastName": "$last","email": "$email","profileImg": "","academieName": "$organization","title": "","bio": "$about","city": "$city","state": "$state","leagueName": "$laegue","flightName": "$flight","instagramLink": "$iglink","twitterLink": "$xlink","sportsId": "$sportid","websitelink":"$website","subscriptionId": 0,"isActive": true}';

    final responce=await http.post(url,headers: header,body: json.toString());

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      StackDialog.show("Connect Athlete", "Profile Updated Successfully", Icons.verified, Colors.green);
      await clubProfileDetailsController.ClubProfileDetailsApi(context);
      // final value=(data['data']);
      // clubeditprofiledata.assignAll([value]);
      // return responce;

    }
    else{
      return responce;
    }
  }
}