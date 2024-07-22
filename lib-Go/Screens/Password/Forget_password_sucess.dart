import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Common/Common Color.dart';
import '../../Common/Common Size.dart';
import '../../Common/Common Textstyle.dart';
import '../../Common/Commonbackground.dart';
import '../Login/Loginscreen.dart';

class Forgetpasswordsucessscreen extends StatefulWidget {
  const Forgetpasswordsucessscreen({super.key});

  @override
  State<Forgetpasswordsucessscreen> createState() => _ForgetpasswordsucessscreenState();
}

class _ForgetpasswordsucessscreenState extends State<Forgetpasswordsucessscreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          commonbackground(context),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: displayheight(context)*0.30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text("Your New Password has been sent to your Registered EmailID.",style: cardtxt,textAlign: TextAlign.center,),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: SizedBox(
                                height:displayheight(context)*0.06,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(backgroundColor: newyellow,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                                    ),
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
                )
              ],
            ),
          )

        ],
      ),
    );
  }
}
