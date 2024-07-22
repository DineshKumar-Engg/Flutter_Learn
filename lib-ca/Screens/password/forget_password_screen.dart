import 'package:connect_athlete_admin/Common/Common%20Color.dart';
import 'package:connect_athlete_admin/Common/Common_textstyle.dart';
import 'package:connect_athlete_admin/Screens/Login/login_screen.dart';
import 'package:connect_athlete_admin/Screens/password/ForgetpasswordController.dart';
import 'package:connect_athlete_admin/Widget/Loading.dart';
import 'package:connect_athlete_admin/Widget/appbar_widget.dart';
import 'package:connect_athlete_admin/Widget/common_textfield.dart';
import 'package:connect_athlete_admin/Widget/elevation_button.dart';
import 'package:connect_athlete_admin/Widget/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class forget_password_screen extends StatefulWidget {
  const forget_password_screen({super.key});

  @override
  State<forget_password_screen> createState() => _forget_password_screenState();
}

class _forget_password_screenState extends State<forget_password_screen> {

  final TextEditingController emailcontroller=TextEditingController();
  final ForgetPasswordController forgetPasswordController=Get.find<ForgetPasswordController>();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     backgroundColor: Colors.white,
      appBar: appbar_widget("Forget Password"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
               Column(
                 children: [
                   Center(
                       child: Padding(
                         padding: const EdgeInsets.symmetric(vertical: 70.0),
                         child: Image.asset("Assets/forget.png"),
                       )),
                   Padding(
                     padding: const EdgeInsets.symmetric(vertical:12.0),
                     child: Text("Enter your Email ID ?",style: appbartxtbold,),
                   ),
                   common_textfield(emailcontroller, "Email ID", TextInputType.emailAddress),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: SizedBox(
                       width: double.infinity,
                       child: ElevatedButton(
                         style: ElevatedButton.styleFrom(
                           backgroundColor: secondary,
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(10)
                           )
                         ),
                           onPressed: (){
                           if(emailcontroller.text.isEmpty){
                             StackDialog.show("Required Field is Empty", "Enter Email ID", Icons.info, Colors.red);
                           }
                           else{
                             showloadingdialog(context);
                             forgetPasswordController.ForgetPasswordApi(context, emailcontroller.text);
                             Navigator.pop(context);
                             emailcontroller.text='';
                           }
                           }, child: Text("Send",style: btntxtwhite,)),
                     ),
                   )
                 ],
               ),
          InkWell(
            onTap: (){
              Get.to(const login_screen());
            },
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Remember password?",style: remembertxt,),
                    Text(" Login",style: remembertxt1,)
                  ],
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}
