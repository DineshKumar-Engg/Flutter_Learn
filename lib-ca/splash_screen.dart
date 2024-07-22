import 'dart:async';

import 'package:connect_athlete_admin/Screens/Home/home_screen.dart';
import 'package:connect_athlete_admin/Screens/Login/login_screen.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Athlete/AthleteSearchController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Club/ClubsearchController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Coach/CoachsearchController.dart';
import 'package:connect_athlete_admin/Screens/Sport/Getall_sport_Controller.dart';
import 'package:connect_athlete_admin/service/Dashboard/GetathleteController.dart';
import 'package:connect_athlete_admin/service/Dashboard/GetclubcountController.dart';
import 'package:connect_athlete_admin/service/Dashboard/GetcoachcountController.dart';
import 'package:connect_athlete_admin/service/Dashboard/OverallprofileController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Common/Common_size.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({super.key});

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {

  final Getall_sport_Controller getall_sport_controller=Get.find<Getall_sport_Controller>();
  final OverallprofileController overallprofileController=Get.find<OverallprofileController>();
  final GetAthleteprofileController getAthleteprofileController=Get.find<GetAthleteprofileController>();
  final GetCoachprofilecountController getCoachprofilecountController=Get.find<GetCoachprofilecountController>();
  final GetClubprofilecountController getClubprofilecountController=Get.find<GetClubprofilecountController>();
  final AthletesearchController athletesearchController=Get.find<AthletesearchController>();
  final CoachsearchController coachsearchController=Get.find<CoachsearchController>();
  final ClubsearchController clubsearchController=Get.find<ClubsearchController>();
  int?sessionid;
  Future<void>splashfun()async{
    final SharedPreferences shref=await SharedPreferences.getInstance();
    var getsessionid=shref.getInt('sessionid');
    sessionid=getsessionid;

    Timer(const Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context)=>
              sessionid==1?
              const home_screen():const login_screen()));
    });
  }

  @override
  void initState() {
splashfun();
getall_sport_controller.GetSportApi(context);
overallprofileController.OverallprofileApi(context);
getAthleteprofileController.GetAthleteprofileApi(context);
getCoachprofilecountController.GetCoachprofilecountApi(context);
getClubprofilecountController.GetClubprofilecountApi(context);
athletesearchController.AthletesearchApi(context, '', '', '', '', '', '', '');
coachsearchController.CoachsearchApi(context, '', '', '', '');
clubsearchController.ClubsearchApi(context, '', '', '', '', '');
super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset("Assets/img.png",height: displayheight(context)*0.15,),
              Image.asset("Assets/img_2.png",height: displayheight(context)*0.15,)
            ],
          ),
          Center(
            child: Image.asset("Assets/logo/bluelogo.png"),
          ),
          SizedBox(
            height: displayheight(context)*0.20,
          )
        ],
      ),
    );
  }
}
