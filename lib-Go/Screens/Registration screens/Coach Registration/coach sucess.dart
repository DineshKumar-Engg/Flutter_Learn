import 'package:animate_do/animate_do.dart';
import 'package:connect_athelete/Screens/Login/Loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../Common/Common Color.dart';
import '../../../Common/Common Size.dart';
import '../../../Common/Common Textstyle.dart';
import '../../../Common/Commonbackground.dart';


class Coachsucess extends StatefulWidget {
  const Coachsucess({super.key});

  @override
  State<Coachsucess> createState() => _CoachsucessState();
}

class _CoachsucessState extends State<Coachsucess> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            commonbackground(context),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: FadeInDownBig(
                    child: Container(
                      height: displayheight(context)*0.30,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FloatingActionButton(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)
                                ),
                                onPressed: (){},child: const CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage("assets/sucess.png"),
                              ),),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text("Thank You For Your Registration,You Will Receive a Email. ",style: cardtxt,textAlign: TextAlign.center,),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5.0),
                              child: SizedBox(
                                height:displayheight(context)*0.06,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(backgroundColor: newyellow,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                    onPressed: (){
                                      Get.to(const Loginscreen());
                                    }, child: Center(child: Text("Continue",style: btntxtwhite,),)),
                              ),
                            ),
                            const SizedBox(height: 20,)
                    
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
      
          ],
        ),
      
      ),
    );
  }
}
