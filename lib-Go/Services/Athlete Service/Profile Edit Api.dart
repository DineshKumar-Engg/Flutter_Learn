import 'dart:convert';
import 'package:connect_athelete/Services/Athlete%20Service/Profile%20Details%20Api.dart';
import 'package:flutter/material.dart';
import 'package:connect_athelete/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../widget/Snackbar.dart';

class ProfileEditController extends GetConnect{
  String ?service;
  RxList<dynamic>profileeditdata=<dynamic>[].obs;
  int?id;
  String usertoken='';
  final ProfiledetailsController profiledetailsController=Get.find<ProfiledetailsController>();

  Future<dynamic> ProfileEditApi(BuildContext context,athletefirst,athletelast,age,gender,
      school,city,state,bio,parentfirst,parentlast,parentemail,parentphone,
      achievments,game,position,sportid,xlink,iglink,spciality,currentclub)async{
    final SharedPreferences shref=await SharedPreferences.getInstance();
    var getid=shref.getInt('userid');
    id=(getid??'') as int;

    var gettoken=shref.getString('token');
    usertoken=gettoken??'token';

    service=ApiConfig.service;

    String baseurl="${service}/api/v1/updateathlete";

    final url=Uri.parse(baseurl);

    final header={
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Authorization':'$usertoken'
    };


    final json='{"id":$id,"firstName": "$athletefirst","lastName": "$athletelast","email": "$parentemail","profileImg": "","age": "$age","gender": "$gender","bio": "$bio","city": "$city","achievements": "$achievments","residentialState": "$state","school": "$school","parentFirstName": "$parentfirst","parentLastName": "$parentlast","parentEmail": "","parentPhone": "$parentphone","parentConsent": true,"instagramLink": "$iglink","twitterLink": "$xlink","athleteSpecialty":"$spciality","currentAcademie":"$currentclub","sportsId":"$sportid","subscriptionId": 0,"isActive": true}';

    final responce=await http.post(url,headers: header,body: json.toString());

    final data=jsonDecode(responce.body);

    if(responce.statusCode==200){
      StackDialog.show("Connect Athlete", "Profile Updated Successfully", Icons.verified, Colors.green);
      await profiledetailsController.ProfiledetailsApi(context);
      // Get.to(Profileupdatesucess(route: 'athlete',));
      // final value=(data['data']);
      // profileeditdata.assignAll(value);
      // return responce;
    }
    else{
      return responce;
    }


  }
}