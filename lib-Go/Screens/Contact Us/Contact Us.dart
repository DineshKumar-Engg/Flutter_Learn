import 'package:connect_athelete/Common/Common%20Color.dart';
import 'package:connect_athelete/Common/Common%20Size.dart';
import 'package:connect_athelete/Common/Common%20Textstyle.dart';
import 'package:connect_athelete/Screens/Contact%20Us/Contact%20us%20Api.dart';
import 'package:connect_athelete/Services/get%20data/setting_list.dart';
import 'package:connect_athelete/widget/Appbar.dart';
import 'package:connect_athelete/widget/Redirect%20Link.dart';
import 'package:connect_athelete/widget/Snackbar.dart';
import 'package:connect_athelete/widget/commonTextfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Conactusscreen extends StatefulWidget {
  const Conactusscreen({super.key});

  @override
  State<Conactusscreen> createState() => _ConactusscreenState();
}

class _ConactusscreenState extends State<Conactusscreen> {

  final TextEditingController firstnamecontroller=TextEditingController();
  final TextEditingController lastnamecontroller=TextEditingController();
  final TextEditingController emailcontroller=TextEditingController();
  final TextEditingController phonecontroller=TextEditingController();
  final TextEditingController messagcontroller=TextEditingController();

  final ContactUscontroller contactUscontroller=Get.find<ContactUscontroller>();
  final SettingController settingController=Get.find<SettingController>();

  @override
  void initState() {
    settingController.SettingApi(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: background,
      appBar: appbarwidget("Contact Us"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              decoration:  BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child:  Padding(
                padding: const EdgeInsets.all(4.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("First Name",style: contactustxt,),
                                ),
                                SizedBox(
                                  width: displaywidth(context)*0.45,
                                    child: commontextfield("", firstnamecontroller,TextInputType.name))
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Last Name",style: contactustxt,),
                                ),
                                SizedBox(
                                    width: displaywidth(context)*0.45,
                                    child: commontextfield("", lastnamecontroller,TextInputType.name))
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Email ID",style: contactustxt,),
                            ),
                            commontextfield("", emailcontroller,TextInputType.emailAddress)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Mobile Number",style: contactustxt,),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextFormField(
                                maxLength: 10,
                                keyboardType:TextInputType.number,
                                style: inputtxt,
                                controller: phonecontroller,
                                cursorColor: greytxtcolor,
                                decoration: InputDecoration(
                                  counterText: "",
                                  prefix: Text("+1",style: inputtxt,),
                                  hintText: "",
                                  hintStyle: textfieldhint,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Message",style: contactustxt,),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextFormField(
                                style: inputtxt,
                                keyboardType: TextInputType.text,
                                controller: messagcontroller,
                                maxLines: 3,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(color:Color(0XFFD9D9D9) )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(color:Color(0XFFD9D9D9) )
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: SizedBox(
                            height: displayheight(context)*0.05,
                            width: displaywidth(context)*0.40,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: newyellow,shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ) ),
                                onPressed: (){
                                  if(firstnamecontroller.text.isEmpty){
                                    StackDialog.show("Required Field is Empty", "Enter Your First Name", Icons.info, Colors.red);
                                  }
                                  else if(emailcontroller.text.isEmpty){
                                    StackDialog.show("Required Field is Empty", "Enter Your Email ID", Icons.info, Colors.red);
                                  }
                                  else if(phonecontroller.text.isEmpty){
                                    StackDialog.show("Required Field is Empty", "Enter Your Mobile Number", Icons.info, Colors.red);
                                  }
                                  else if(messagcontroller.text.isEmpty){
                                    StackDialog.show("Required Field is Empty", "Enter Your Message", Icons.info, Colors.red);
                                  }
                                  else{
                                    contactUscontroller.ContactusApi(context,firstnamecontroller.text,lastnamecontroller.text,emailcontroller.text,phonecontroller.text,messagcontroller.text);
                                  }

                                }, child: Text("Submit",style: passchangetxt,)),
                          ),
                        ),
                      )
                    ],
                  )
                ),
              ),
            ),
            socialmedialinks()

          ],
        ),
      ),
    );
  }
  Widget socialmedialinks(){
    var data=settingController.settingdata[0];
    return  Column(
      children: [
        Text("Follow Us On",style: inputtxt,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                  onTap: (){
                    urllauncher("${data['twitterLink']}");
                  },
                  child: Image.asset("assets/Media/xlink.png",height:displayheight(context)*0.10,width:displaywidth(context)*0.10,)),
              InkWell(
                  onTap: (){
                    urllauncher("${data['instagramLink']}");
                  },
                  child: Image.asset("assets/Media/iglink.png",height:displayheight(context)*0.10,width:displaywidth(context)*0.10,)),
              InkWell(
                  onTap: (){
                    urllauncher("https://admin.engageathlete.com");
                  },
                  child: Image.asset("assets/Media/weblink.png",height:displayheight(context)*0.10,width:displaywidth(context)*0.10,)),
              InkWell(
                  onTap: (){
                    urllauncher("${data['facebookLink']}");
                  },
                  child: Image.asset("assets/Media/fblink.png",height:displayheight(context)*0.10,width:displaywidth(context)*0.10,)),
              InkWell(
                  onTap: (){
                    urllauncher("${data['youtubeLink']}");
                  },
                  child: Image.asset("assets/img_12.png",height:displayheight(context)*0.09,width:displaywidth(context)*0.09,))
            ],
          ),
        ),
      ],
    );
  }
}
