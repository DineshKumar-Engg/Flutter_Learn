import 'package:connect_athelete/Common/Common%20Color.dart';
import 'package:connect_athelete/Common/Commonbackground.dart';
import 'package:connect_athelete/widget/Backbutton.dart';
import 'package:connect_athelete/widget/Container.dart';
import 'package:connect_athelete/widget/Divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Common/Common Size.dart';
import '../../Common/Common Textstyle.dart';
import 'Aboutscreen.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}
 String?profile;
int?radio=3;
class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          commonbackground(context),
          Padding(
            padding: const EdgeInsets.only(top:5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
               Padding(
            padding: const EdgeInsets.only(left:20.0,top: 55.0),
               child: CircleAvatar(
              radius: 20,
              backgroundColor: newyellow,
              child: Center(
                child: IconButton(onPressed: (){Get.back();},icon: const Icon(Icons.arrow_back_ios_new,color: Colors.white,),),
              ),
            ),
          ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Padding(
                      padding: const EdgeInsets.only(left:40.0),
                      child: Image.asset("assets/logo/logowhite.png",color:newyellow,height: displayheight(context)*0.15,),
                    )),
                  ),

            ],
              ),
               Padding(
                 padding: const EdgeInsets.only(left:8.0),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Padding(
                       padding: const EdgeInsets.only(left:12.0),
                       child: Text("Signup",style: requesttxtbold,),
                     ),
                     Padding(
                       padding: const EdgeInsets.only(left:12.0),
                       child: Text("Please sign up to continue",style: requesttxt,),
                     ),
                   ],
                 ),
               ),
                commoncontainer(
                    displayheight(context)*0.50,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Choose your profile",style: signuptxt,),
                              ),
                              ListTile(
                                onTap: (){
                                  radio=0;
                                  Get.to(Aboutscreen(route:'Athlete'));
                                  setState(() {
                                    radio=radio!;
                                  });
                                },
                                leading:Text("Athlete",style:radio==0?signupsubtxt: signupsubsubtxt,),
                              trailing:Icon(Icons.arrow_forward_ios_rounded,color: radio==0?primary:Colors.black,) ,
                              ),

                              commondivider(const Color(0XFFD9D9D9)),
                              ListTile(
                                onTap: (){
                                  radio=1;
                                  Get.to(Aboutscreen(route:'Coach'));
                                  setState(() {
                                    radio=radio!;
                                  });
                                },
                                leading:Text("Coach",style:radio==1?signupsubtxt: signupsubsubtxt,),
                                trailing:Icon(Icons.arrow_forward_ios_rounded,color: radio==1?primary:Colors.black,) ,
                              ),
                              commondivider(const Color(0XFFD9D9D9)),
                              ListTile(
                                onTap: (){
                                  radio=2;
                                  Get.to(Aboutscreen(route:'Clubs'));
                                  setState(() {
                                    radio=radio!;
                                  });
                                },
                                leading:Text("Club and Academy",style:radio==2?signupsubtxt: signupsubsubtxt,),
                                trailing:Icon(Icons.arrow_forward_ios_rounded,color: radio==2?primary:Colors.black,) ,
                              ),
                              commondivider(const Color(0XFFD9D9D9))
                      ]


                        ),
                          // Padding(
                          //   padding: const EdgeInsets.only(bottom:10.0,left: 8.0,right: 8.0),
                          //   child: SizedBox(
                          //     height:displayheight(context)*0.06,
                          //     child: ElevatedButton(
                          //         style: ElevatedButton.styleFrom(backgroundColor: primary
                          //         ),
                          //         onPressed: (){
                          //           if(radio==0){
                          //             Get.to(const Atheletescreen());
                          //           }
                          //           else if(radio==1){
                          //             Get.to(const Coachscreen());
                          //           }
                          //           else{
                          //             Get.to(const Clubsscreen());
                          //           }
                          //
                          //
                          //         }, child: Center(child: Text("Continue",style: btntxtwhite,),)),
                          //   ),
                          // ),

                        ],
                      ),
                    ))
              ],),
          )

        ],
      ),
    );
  }
}
