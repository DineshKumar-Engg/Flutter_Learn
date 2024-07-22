import 'package:connect_athlete_admin/Common/Common%20Color.dart';
import 'package:connect_athlete_admin/Common/Common_size.dart';
import 'package:connect_athlete_admin/Common/Common_textstyle.dart';
import 'package:connect_athlete_admin/Screens/Home/home_screen.dart';
import 'package:connect_athlete_admin/Screens/Login/login_Controller.dart';
import 'package:connect_athlete_admin/Screens/Speciality/Getspeciality_Controller.dart';
import 'package:connect_athlete_admin/Screens/Sport/Getall_sport_Controller.dart';
import 'package:connect_athlete_admin/Screens/password/forget_password_screen.dart';
import 'package:connect_athlete_admin/Widget/elevation_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class login_screen extends StatefulWidget {
  const login_screen({super.key});

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {

  final login_Controller login_controller=Get.find<login_Controller>();
  final Getspeciality_Controller getspeciality_controller=Get.find<Getspeciality_Controller>();
  final Getall_sport_Controller getall_sport_controller=Get.find<Getall_sport_Controller>();

  final TextEditingController emailcontroller=TextEditingController();
  final TextEditingController passwordcontroller=TextEditingController();
  bool toggle=false;
  var _formkey=GlobalKey<FormState>();

  @override
  void initState() {
    getspeciality_controller.GetspecialityApi(context);
    getall_sport_controller.GetSportApi(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset("Assets/img.png",height: displayheight(context)*0.15,),
              Image.asset("Assets/img_2.png",height: displayheight(context)*0.15,)
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top:30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80.0),
                  child: Image.asset("Assets/logo/bluelogo.png"),
                ),
                Text("Login",style: loginheadingtxt,),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(color: textfieldcolor,),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          style: inputtxt,
                          cursorColor: Colors.black,
                          controller: emailcontroller,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value){
                            if(value==null||value.isEmpty){
                              return "Required field is empty *";
                            }
                            return null;
                          },
                          decoration:  InputDecoration(
                              hintText: "Email ID",
                              hintStyle:loginhinttxt ,
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: textfieldcolor),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0)
                                  )
                              ),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: textfieldcolor),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0)
                                  )
                              )
                          ),
                        ),
                        TextFormField(
                          style: inputtxt,
                          obscureText: !toggle,
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.text,
                          controller: passwordcontroller,
                          validator: (value){
                            if(value==null||value.isEmpty){
                              return "Required field is empty *";
                            }
                            return null;
                          },
                          decoration:  InputDecoration(
                              suffixIcon:IconButton(onPressed: (){
                                setState(() {
                                  toggle=!toggle;
                                });
                              },icon: Icon(toggle?CupertinoIcons.eye:CupertinoIcons.eye_slash,color: primary,),),
                            hintText: "Password",
                              hintStyle:loginhinttxt ,
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: textfieldcolor),
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10.0),
                                      bottomLeft: Radius.circular(10.0)
                                  )
                              ),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: textfieldcolor),
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10.0),
                                      bottomLeft: Radius.circular(10.0)
                                  )
                              )
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(onPressed: (){
                              Get.to(const forget_password_screen());
                            }, child: Text("Forget Password?",style:forgettxt,))),
                            Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: displayheight(context)*0.06,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: secondary,shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          )),
                          child: Text("Continue",style: btntxtwhite,),
                          onPressed: (){
                            if (_formkey.currentState!.validate()) {
                              login_controller.loginApi(context, emailcontroller.text, passwordcontroller.text,
                              );
                            }                          },
                        ),
                      ),
                    ),
                      ],
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
