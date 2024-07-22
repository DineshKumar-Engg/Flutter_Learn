import 'package:flutter/material.dart';
import '../../Common/Common Color.dart';
import '../../Common/Common Size.dart';
import '../../Common/Common Textstyle.dart';
import '../../Common/Commonbackground.dart';
import '../../Services/password_service/forget_password_api.dart';
import '../../widget/Snackbar.dart';
import '../../widget/commonTextfield.dart';
import 'package:get/get.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

  final TextEditingController emailcontroller=TextEditingController();
  final ForgetPasswordController forgetPasswordController=Get.find<ForgetPasswordController>();

  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          commonbackground(context),
          Padding(
            padding: const EdgeInsets.only(top:20.0),
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
                        backgroundColor:newyellow,
                        child: Center(
                          child: IconButton(onPressed: (){Get.back();},icon: const Icon(Icons.arrow_back_ios_new,color: Colors.white,),),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Padding(
                        padding: const EdgeInsets.only(left:40.0),
                        child: Image.asset("assets/logo/logowhite.png",height: displayheight(context)*0.15,color: newyellow, ),
                      )),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left:8.0),
                                child: Text("Forget Password",style: requesttxtbold,),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0),
                                child: Text("Please Enter your EmailID to continue",style: requesttxt,),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // height: displayheight(context)*0.50,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40)
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top:12.0,left: 12.0,right: 12.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Email ID",style:textfieldtxt,),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: commontextfield("name@example.com",emailcontroller,TextInputType.emailAddress),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                                  child: SizedBox(
                                    height:displayheight(context)*0.06,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(backgroundColor: newyellow,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10)
                                            )
                                        ),
                                        onPressed: (){
                                          if(emailcontroller.text.isEmpty){
                                            StackDialog.show("Required Field is Empty", "Enter Email Id", Icons.info, Colors.red);
                                          }

                                          else{
                                            forgetPasswordController.ForgetPasswordApi(context,emailcontroller.text);
                                          }
                                        }, child: Center(child: Text("Continue",style: btntxtwhite,),)),
                                  ),
                                ),
                              ),
                              Container(
                                height: displayheight(context)*0.20,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )



              ],
            ),
          ),

        ],
      ),
    );
  }
}
