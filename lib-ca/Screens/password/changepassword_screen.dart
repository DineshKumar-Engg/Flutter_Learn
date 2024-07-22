import 'package:connect_athlete_admin/Common/Common%20Color.dart';
import 'package:connect_athlete_admin/Common/Common_size.dart';
import 'package:connect_athlete_admin/Common/Common_textstyle.dart';
import 'package:connect_athlete_admin/Screens/password/Changepassword_Controller.dart';
import 'package:connect_athlete_admin/Widget/appbar_widget.dart';
import 'package:connect_athlete_admin/Widget/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangepasswordScreen extends StatefulWidget {
  const ChangepasswordScreen({super.key});

  @override
  State<ChangepasswordScreen> createState() => _ChangepasswordScreenState();
}

class _ChangepasswordScreenState extends State<ChangepasswordScreen> {

  final Changepasswordcontroller changepasswordcontroller=Get.find<Changepasswordcontroller>();

  final TextEditingController oldpasswordcontroller=TextEditingController();
  final TextEditingController newpasswordcontroller=TextEditingController();
  final TextEditingController confirmpasswordcontroller=TextEditingController();

  bool oldpassword=false;
  bool newpassword=false;
  bool confirmpassword=false;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: background,
      appBar: appbar_widget("Change Password"),
      body:  Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(215, 215, 215, 0.83),
                      offset: Offset(2,6),
                      blurRadius: 30,
                      spreadRadius: 1,
                    )
                  ]
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Old Password",style: viewtxt,),
                ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: SizedBox(
                        height: displayheight(context)*0.06,
                        child: TextFormField(
                          style: inputtxt,
                          cursorColor: Colors.black,
                          controller: oldpasswordcontroller,
                          keyboardType: TextInputType.text,
                          obscureText: oldpassword,
                          decoration:  InputDecoration(
                            suffixIcon: IconButton(onPressed: (){
                              setState(() {
                                oldpassword=!oldpassword;
                              });
                            }, icon: Icon(oldpassword?CupertinoIcons.eye:CupertinoIcons.eye_slash)),
                              hintText:"**********",
                              hintStyle:loginhinttxt ,
                              enabledBorder:  OutlineInputBorder(
                                  borderSide: const BorderSide(color: textfieldcolor),
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              focusedBorder:  OutlineInputBorder(
                                  borderSide: const BorderSide(color: textfieldcolor),
                                  borderRadius: BorderRadius.circular(10.0)
                              )
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("New Password",style: viewtxt,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: SizedBox(
                        height: displayheight(context)*0.06,
                        child: TextFormField(
                          style: inputtxt,
                          cursorColor: Colors.black,
                          controller: newpasswordcontroller,
                          keyboardType: TextInputType.text,
                          obscureText: newpassword,
                          decoration:  InputDecoration(
                              suffixIcon: IconButton(onPressed: (){
                                setState(() {
                                  newpassword=!newpassword;
                                });
                              }, icon: Icon(newpassword?CupertinoIcons.eye:CupertinoIcons.eye_slash)),
                              hintText:"**********",
                              hintStyle:loginhinttxt ,
                              enabledBorder:  OutlineInputBorder(
                                  borderSide: const BorderSide(color: textfieldcolor),
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              focusedBorder:  OutlineInputBorder(
                                  borderSide: const BorderSide(color: textfieldcolor),
                                  borderRadius: BorderRadius.circular(10.0)
                              )
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Confirm New Password",style: viewtxt,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: SizedBox(
                        height: displayheight(context)*0.06,
                        child: TextFormField(
                          style: inputtxt,
                          cursorColor: Colors.black,
                          controller: confirmpasswordcontroller,
                          keyboardType: TextInputType.text,
                          obscureText: confirmpassword,
                          decoration:  InputDecoration(
                              suffixIcon: IconButton(onPressed: (){
                                setState(() {
                                  confirmpassword=!confirmpassword;
                                });
                              }, icon: Icon(confirmpassword?CupertinoIcons.eye:CupertinoIcons.eye_slash)),
                              hintText:"*********",
                              hintStyle:loginhinttxt ,
                              enabledBorder:  OutlineInputBorder(
                                  borderSide: const BorderSide(color: textfieldcolor),
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              focusedBorder:  OutlineInputBorder(
                                  borderSide: const BorderSide(color: textfieldcolor),
                                  borderRadius: BorderRadius.circular(10.0)
                              )
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  onPressed: (){
                    if(oldpasswordcontroller.text.isEmpty){
                      StackDialog.show("Required Field is Empty", "Enter Old Password", Icons.info, Colors.red);
                    }
                    else if(newpasswordcontroller.text.isEmpty){
                      StackDialog.show("Required Field is Empty", "Enter New Password", Icons.info, Colors.red);
                    }
                    else if(confirmpasswordcontroller.text.isEmpty){
                      StackDialog.show("Required Field is Empty", "Enter Confirm Password", Icons.info, Colors.red);
                    }
                    else if(newpasswordcontroller.text!=confirmpasswordcontroller.text){
                      StackDialog.show("Not Matched", "New password & Confirm Password ", Icons.info, Colors.red);
                    }
                    else{
                      changepasswordcontroller.changepasswordapi(context, oldpasswordcontroller.text, newpasswordcontroller.text);
                      oldpasswordcontroller.text='';
                      newpasswordcontroller.text='';
                      confirmpasswordcontroller.text='';
                    }
                  }, child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Submit",style: btntxtwhite,),
                  )),
            )

          ],
        )
      ),
    );
  }
}
