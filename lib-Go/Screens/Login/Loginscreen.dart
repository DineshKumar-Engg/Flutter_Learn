import 'dart:async';
import 'dart:math';
import 'package:connect_athelete/Common/Common%20Color.dart';
import 'package:connect_athelete/Common/Commonbackground.dart';
import 'package:connect_athelete/Screens/Login/LoginController.dart';
import 'package:connect_athelete/Screens/Login/Sign%20up.dart';
import 'package:connect_athelete/Screens/Password/forget%20password.dart';
import 'package:connect_athelete/Services/Announcement/commonAnnouncement.dart';
import 'package:connect_athelete/Services/CMS%20Service/Terms_api.dart';
import 'package:connect_athelete/Services/CMS%20Service/cms_api.dart';
import 'package:connect_athelete/Services/CMS%20Service/parent_contest_api.dart';
import 'package:connect_athelete/Services/Favourite/get_favourite_list.dart';
import 'package:connect_athelete/Services/get%20data/List%20Sports.dart';
import 'package:connect_athelete/Services/get%20data/getall_cities.dart';
import 'package:connect_athelete/Services/get%20data/setting_list.dart';
import 'package:connect_athelete/Services/get%20data/state_list.dart';
import 'package:connect_athelete/widget/Loading.dart';
import 'package:connect_athelete/widget/commonTextfield.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:text_divider/text_divider.dart';
import '../../Common/Common Size.dart';
import '../../Common/Common Textstyle.dart';
import '../../widget/Snackbar.dart';


class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}
 bool toggle=false;
class _LoginscreenState extends State<Loginscreen> {

  final TextEditingController emailcontroller=TextEditingController();
  final TextEditingController passwordcontroller=TextEditingController();
  final TextEditingController controller=TextEditingController();


  bool toggle=false;
  final LoginApi loginApi=Get.find<LoginApi>();
  final StatelistController statelistController=Get.find<StatelistController>();
  final Sportslistcontroller  sportslistcontroller=Get.find<Sportslistcontroller>();
  final GetallCitiesController getallCitiesController=Get.find<GetallCitiesController>();
  final CMSController cmsController=Get.find<CMSController>();
  final Getallfavourite_Controller getallfavourite_controller=Get.find<Getallfavourite_Controller>();
  final CMSTermsController cmsTermsController=Get.find<CMSTermsController>();
  final CMSParentcontestController cmsParentcontestController=Get.find<CMSParentcontestController>();
  final SettingController settingController=Get.find<SettingController>();

  late StreamSubscription subscription;
  var isDeviceConnected=false;
  bool isAlertSet=false;
  bool finalcaptchaverified=false;
  String randomString="";
  String verificationText="";
  bool isverified=false;
  bool showVerificationIcon=false;

  void buildcaptcha(){
    const letters="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
    const length=6;
    final random=Random();
    randomString=String.fromCharCodes(List.generate(length, (index) => letters.codeUnitAt(random.nextInt(letters.length))));
    setState(() {});
  }
  @override
  void initState() {
    buildcaptcha();
    getConnectivity();
   statelistController.StatelistApi(context);
   sportslistcontroller.sportslistapi(context);
   getallCitiesController.GetallCitiesApi(context);
   cmsController.cmsapi(context,1);
   cmsTermsController.cmstermsapi(context);
   cmsParentcontestController.cmsparentcontestapi(context);
   settingController.SettingApi(context);
   // commonAnnouncementController.CommonAnnouncementApi(context);
    super.initState();
  }

  getConnectivity() => subscription = Connectivity().onConnectivityChanged.listen((_) async {
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    if (!isDeviceConnected &&isAlertSet==false) {
      showDialogbox();
      setState(() => isAlertSet = true);
    }
  });

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                Center(child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Image.asset("assets/logo/logowhite.png",color: newyellow,),
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Text("Login",style: requesttxtbold,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Text("Please sign in to continue",style: requesttxt,),
                        ),
                      ],
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
                              child: Text("Email",style:textfieldtxt,),
                            ),
                          ),
                          commontextfield("name@gmail.com",emailcontroller,TextInputType.emailAddress),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Password",style:textfieldtxt,),
                          ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(
                          height: displayheight(context)*0.07,
                          child: TextFormField(
                            style: inputtxt,
                            controller: passwordcontroller,
                            obscureText:!toggle,
                            cursorColor: greytxtcolor,
                            decoration: InputDecoration(
                              suffixIcon:IconButton(onPressed: (){
                                setState(() {
                                  toggle=!toggle;
                                });
                              },icon: Icon(toggle?CupertinoIcons.eye:CupertinoIcons.eye_slash,color: primary,),),
                              hintText: "Password",
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
                            alignment: Alignment.centerRight,
                            child: TextButton(onPressed: (){
                              Get.to(const ForgetPassword());
                            }, child: Text("Forget Password?",style: forgrttxt,)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: (){
                                showCaptchaDialogbox(context);
                              },
                              child: Container(
                                width: double.infinity,
                                decoration:BoxDecoration(
                                  color: const Color(0XFFF9F9F9),
                                    border: Border.all(color:const Color(0XFFD3D3D3)),
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
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Checkbox(
                                            activeColor: primary,
                                              value: finalcaptchaverified,
                                              onChanged: (value){
                                              setState(() {
                                                // finalcaptchaverified=value!;
                                              });

                                          }),
                                          Text("I'm not a robot",style: inputtxt,)

                                        ],
                                      ),
                                      Image.asset("assets/recaptcha.png")
                                    ],
                                  ),
                                ),

                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom:10.0),
                            child: SizedBox(
                              height:displayheight(context)*0.06,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: newyellow,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                    )
                                  ),
                                  onPressed: ()async{
                                    if(emailcontroller.text.isEmpty){
                                      StackDialog.show("Required Field is Empty", "Enter Email Id", Icons.info, Colors.red);
                                    }
                                    else if(passwordcontroller.text.isEmpty){
                                      StackDialog.show("Required Field is Empty", "Enter Password", Icons.info, Colors.red);
                                    }
                                    else if(finalcaptchaverified==false){
                                      StackDialog.show("ReCaptcha", "ReCaptcha Not Verified", Icons.info, Colors.red);
                                    }
                                    else{
                                      showloadingdialog(context);
                                      loginApi.loginapi(context,emailcontroller.text,passwordcontroller.text);
                                      Navigator.pop(context);
                                    }
                                  }, child: Center(child: Text("Continue",style: btntxtwhite,),)),
                            ),
                          ),
                          TextDivider.horizontal(
                            text:  Text('or',style:secondarysign ,),
                            color: primary,
                            thickness: 1.0,
                          ),
                          InkWell(
                            onTap: (){
                              Get.to(const Signup());
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom:15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                 Text("New To Connect Athlete? ",style: logindonttxt,),
                                  Text("Register Now",style: secondarysign,)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }

    showDialogbox()async{
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title:  Text("Connection Error",style:primaryheading ,),
        content:  Text("Please Check your Internet Connectivity.",style:inputtxt,),
        actions: [
          TextButton(onPressed: ()async{
            Navigator.pop(context,'Cancel');
            setState(()=>isAlertSet=false);
            isDeviceConnected=await InternetConnectionChecker().hasConnection;
            if(!isDeviceConnected){
              showDialogbox();
              setState(()=>isAlertSet=true);
            }
          }, child:  Text("OK",style: drawertxt,))
        ],
      );
    });
  }

  showCaptchaDialogbox(BuildContext context)async{
    buildcaptcha();
    return showDialog(context: context, builder: (BuildContext context){
      return StatefulBuilder(
        builder: (context,setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
            ),
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            title: Column(
              children: [
                Text("Enter the ReCaptcha", style: inputtxt,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("$randomString", style: primaryheading,),
                      IconButton(onPressed: () {
                        buildcaptcha();
                        setState(() {

                        });
                      }, icon: const Icon(
                        CupertinoIcons.refresh, color: Colors.black,))

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: displayheight(context) * 0.06,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      style: inputtxt,
                      controller: controller,
                      cursorColor: greytxtcolor,
                      decoration: InputDecoration(
                        hintText: "",
                        hintStyle: textfieldhint,
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFFD9D9D9)),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFFD9D9D9)),
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: newyellow,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        )),
                    onPressed: () {
                      isverified = controller.text == randomString;
                      if (isverified) {
                        verificationText = "Verified!";
                        finalcaptchaverified = true;
                        StackDialog.show(
                            "Successfully", "ReCaptcha Verified", Icons
                            .verified, Colors.green);
                        Navigator.pop(context);
                      } else {
                        verificationText = "Please enter valid captcha";
                        finalcaptchaverified = false;
                        StackDialog.show(
                            "Didn't Match", "Enter the Valid ReCaptcha", Icons
                            .info, Colors.red);
                      }
                      setState(() {

                      });
                    }, child: Text("Submit", style: btntxtwhite,))
              ],
            ),
          );
        }
      );
    });
  }
}
