import 'dart:async';
import '../../Common/Common Color.dart';
import 'package:flutter/material.dart';
import '../../Common/Common Textstyle.dart';
import '../Athlete/Athlete Homescreen.dart';
import '../Club/Club Homescreen.dart';
import '../Coach/Coach Homescreen.dart';


class Passwordsucessscreen extends StatefulWidget {
  String route;
   Passwordsucessscreen({super.key,required this.route});

  @override
  State<Passwordsucessscreen> createState() => _PasswordsucessscreenState();
}

class _PasswordsucessscreenState extends State<Passwordsucessscreen> {

  Future<void>sucesssplash()async{
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
          widget.route=="athlete"?
           const AthleteHomescreen():
          widget.route=="coach"?
          const CoachHomescreen():
          widget.route=="club"?
          const ClubsHomescreen():
              Container()

      ));
    });
  }


  @override
  void initState() {
   sucesssplash();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(30)
                ),
                child:  Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 35,
                        backgroundColor: Color(0XFF00B753),
                        child: Center(
                          child: Icon(Icons.done,color: Colors.white,size: 40,),
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 15.0),
                        child: Text("Your Password has been Reset Successfully",style: passchangetxt,textAlign:TextAlign.center,),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
