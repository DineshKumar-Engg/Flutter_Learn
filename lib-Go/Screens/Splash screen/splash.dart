import 'dart:async';
import 'package:connect_athelete/Common/Common%20Color.dart';
import 'package:connect_athelete/Common/Common%20Size.dart';
import 'package:connect_athelete/Common/Commonbackground.dart';
import 'package:connect_athelete/Screens/Athlete/Athlete%20Homescreen.dart';
import 'package:connect_athelete/Screens/Club/Club%20Homescreen.dart';
import 'package:connect_athelete/Screens/Coach/Coach%20Homescreen.dart';
import 'package:connect_athelete/Screens/Login/Loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
 String?userid;
  Future<void>splashfun()async{
    final pref=await SharedPreferences.getInstance();
    setState(() {
      userid=pref.getString("sessionid");
    });
    Timer(const Duration(seconds:3),(){
      Navigator.pushReplacement(
          context, MaterialPageRoute(
          builder: (context)=>
          userid=="athlete"?
          const AthleteHomescreen()
              :userid=="coach"?
          const CoachHomescreen():
          userid=="club"?
          const ClubsHomescreen():
              const Loginscreen()
      ));
    });
  }

  @override
  void initState(){
    splashfun();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          commonbackground(context),
          // Center(
           Center(
            child: Image.asset("assets/logo/logowhite.png",color: newyellow,),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: displayheight(context)*0.21,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/img_4.png"),
                  Image.asset("assets/img_5.png"),
                  Image.asset("assets/img_6.png"),
                  Image.asset("assets/img_7.png")
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
