import 'package:flutter/cupertino.dart';

import '../../Common/Common Color.dart';
import '../../Common/Common Size.dart';
import '../../Common/Common Textstyle.dart';
import '../../Services/password_service/Change password Api.dart';
import '../../widget/Appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/Snackbar.dart';

class ChangePasswordnew extends StatefulWidget {
  String route;
   ChangePasswordnew({super.key,required this.route});

  @override
  State<ChangePasswordnew> createState() => _ChangePasswordnewState();
}

class _ChangePasswordnewState extends State<ChangePasswordnew> {
  final TextEditingController oldpassword=TextEditingController();
  final TextEditingController newpassword=TextEditingController();
  final TextEditingController confirmpassword=TextEditingController();

  final Changepasswordcontroller changepasswordcontroller=Get.find<Changepasswordcontroller>();

  bool toggle=false;
  bool toggle1=false;
  bool toggle2=false;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:background,
      appBar: appbarwidget("Change Password"),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0,horizontal: 20.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: commonshadow20,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Old Password",style: changepasswordtxt,),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        height: 50,
                        child: TextFormField(
                          style: inputtxt,
                          controller: oldpassword,
                          obscureText:!toggle,
                          cursorColor: greytxtcolor,
                          decoration: InputDecoration(
                            suffixIcon:IconButton(onPressed: (){
                              setState(() {
                                toggle=!toggle;
                              });
                            },icon: Icon(toggle?CupertinoIcons.eye:CupertinoIcons.eye_slash,color: primary,),),
                            hintText: "*********",
                            hintStyle: textfieldhint,
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color:Color(0xFFD9D9D9)),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
                                borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("New Password",style: changepasswordtxt,),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        height: 50,
                        child: TextFormField(
                          controller: newpassword,
                          obscureText:!toggle1,
                          style: inputtxt,
                          cursorColor: greytxtcolor,
                          decoration: InputDecoration(
                            suffixIcon:IconButton(onPressed: (){
                              setState(() {
                                toggle1=!toggle1;
                              });
                            },icon: Icon(toggle1?CupertinoIcons.eye:CupertinoIcons.eye_slash,color: primary,),),
                            hintText: "*********",
                            hintStyle: textfieldhint,
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color:Color(0xFFD9D9D9)),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
                                borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Confirm Password",style: changepasswordtxt,),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        height: 50,
                        child: TextFormField(
                          style: inputtxt,
                          controller: confirmpassword,
                          obscureText:!toggle2,
                          cursorColor: greytxtcolor,
                          decoration: InputDecoration(
                            suffixIcon:IconButton(onPressed: (){
                              setState(() {
                                toggle2=!toggle2;
                              });
                            },icon: Icon(toggle2?CupertinoIcons.eye:CupertinoIcons.eye_slash,color: primary,),),
                            hintText: "*********",
                            hintStyle: textfieldhint,
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color:Color(0xFFD9D9D9)),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
                                borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical:20.0),
                        child: SizedBox(
                            height: displayheight(context)*0.05,
                            width: displaywidth(context)*0.30,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: newyellow,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                onPressed: (){
                                if(oldpassword.text.isEmpty){
                                  StackDialog.show("Required Field is Empty", "Enter Old Password", Icons.info, Colors.red);
                                }
                                else if(newpassword.text.isEmpty){
                                  StackDialog.show("Required Field is Empty", "Enter New Password", Icons.info, Colors.red);
                                }
                                else if(confirmpassword.text.isEmpty){
                                  StackDialog.show("Required Field is Empty", "Enter Confirm Password", Icons.info, Colors.red);
                                }
                                else if(confirmpassword.text!=newpassword.text){
                                  StackDialog.show("Required Field is Empty", "Password Didnt Match", Icons.info, Colors.red);
                                }
                                else{
                                  changepasswordcontroller.changepasswordapi(context,oldpassword.text,newpassword.text,widget.route);
                                  oldpassword.text='';
                                  newpassword.text='';
                                  confirmpassword.text='';
                                }
                                }, child: Text("Update",style: btntxtnew,))),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      )

    );
  }
}
