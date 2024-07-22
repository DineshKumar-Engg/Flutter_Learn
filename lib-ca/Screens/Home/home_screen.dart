import 'package:connect_athlete_admin/Common/Common%20Color.dart';
import 'package:connect_athlete_admin/Common/Common_size.dart';
import 'package:connect_athlete_admin/Common/Common_textstyle.dart';
import 'package:connect_athlete_admin/Screens/Billing/Getall_Billing_Controller.dart';
import 'package:connect_athlete_admin/Screens/Billing/billing_state.dart';
import 'package:connect_athlete_admin/Screens/Contact/Getall_Contact_Controller.dart';
import 'package:connect_athlete_admin/Screens/Contact/contact_screen.dart';
import 'package:connect_athlete_admin/Screens/Login/login_screen.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Athlete/AthleteSearchController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Athlete/GetallathleteController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Athlete/athlete_report.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Club/ClubsearchController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Club/club_report.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Coach/CoachsearchController.dart';
import 'package:connect_athlete_admin/Screens/Profile_report/Coach/coach_report.dart';
import 'package:connect_athlete_admin/Screens/Speciality/Getspeciality_Controller.dart';
import 'package:connect_athlete_admin/Screens/Speciality/speciality_screen.dart';
import 'package:connect_athlete_admin/Screens/Sport/Getall_sport_Controller.dart';
import 'package:connect_athlete_admin/Screens/Sport/sport_screen.dart';
import 'package:connect_athlete_admin/Screens/password/changepassword_screen.dart';
import 'package:connect_athlete_admin/Screens/payment_reports/athlete/athlete_payments.dart';
import 'package:connect_athlete_admin/Screens/payment_reports/athlete/athlete_payments_Controller.dart';
import 'package:connect_athlete_admin/Screens/payment_reports/club/club_payment_Controller.dart';
import 'package:connect_athlete_admin/Screens/payment_reports/club/club_payments.dart';
import 'package:connect_athlete_admin/Screens/payment_reports/promocode/promocode_payments_Controller.dart';
import 'package:connect_athlete_admin/Screens/payment_reports/promocode/promocode_reports.dart';
import 'package:connect_athlete_admin/Screens/profile/GetprofiileController.dart';
import 'package:connect_athlete_admin/Screens/profile/profile_edit.dart';
import 'package:connect_athlete_admin/Screens/promocode/Getall_proocode_Controller.dart';
import 'package:connect_athlete_admin/Screens/promocode/promo_code_screen.dart';
import 'package:connect_athlete_admin/Screens/subscription/Getall_subscription_Controller.dart';
import 'package:connect_athlete_admin/Screens/subscription/subscription_screen.dart';
import 'package:connect_athlete_admin/Widget/drawer_listtile.dart';
import 'package:connect_athlete_admin/service/CitylistController.dart';
import 'package:connect_athlete_admin/service/Dashboard/GetathleteController.dart';
import 'package:connect_athlete_admin/service/Dashboard/GetclubcountController.dart';
import 'package:connect_athlete_admin/service/Dashboard/GetcoachcountController.dart';
import 'package:connect_athlete_admin/service/Dashboard/OverallprofileController.dart';
import 'package:connect_athlete_admin/service/GetStatelistController.dart';
import 'package:connect_athlete_admin/service/Get_sportlist_Controller.dart';
import 'package:connect_athlete_admin/service/GetcitylistController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Widget/Loading.dart';

class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {

  String?Selectedsport,Selectedstate,Selecteddata,adminprofile='';
  int?sportid;
  bool reportsbool=false;
  List agelist=['sample','sample1','sample2'];
  bool sportbool=false;
  bool?paymentbool=false;


  final Getspeciality_Controller getspeciality_controller=Get.find<Getspeciality_Controller>();
  final Get_sport_Controller get_sport_controller=Get.find<Get_sport_Controller>();
  final Getall_Billing_Controller getall_billing_controller=Get.find<Getall_Billing_Controller>();
  final Getall_sport_Controller getall_sport_controller=Get.find<Getall_sport_Controller>();
  final Getall_promocode_Controller getall_promocode_controller=Get.find<Getall_promocode_Controller>();
  final Getall_subscription_Controller getall_subscription_controller=Get.find<Getall_subscription_Controller>();
  final Getall_contact_Controller getall_contact_controller=Get.find<Getall_contact_Controller>();
  final StatelistController statelistController=Get.find<StatelistController>();
  final GetallAthleteController getallAthleteController=Get.find<GetallAthleteController>();
  final GetProfileController getProfileController=Get.find<GetProfileController>();
  final GetallCitylistController citylistController=Get.find<GetallCitylistController>();
  final CitylistController citylistControllers=Get.find<CitylistController>();
  final GetAthleteprofileController getAthleteprofileController=Get.find<GetAthleteprofileController>();
  final AthletesearchController athletesearchController=Get.find<AthletesearchController>();
  final ClubsearchController clubsearchController=Get.find<ClubsearchController>();
  final CoachsearchController coachsearchController=Get.find<CoachsearchController>();
  final OverallprofileController overallprofileController=Get.find<OverallprofileController>();
  final GetCoachprofilecountController getCoachprofilecountController=Get.find<GetCoachprofilecountController>();
  final GetClubprofilecountController getClubprofilecountController=Get.find<GetClubprofilecountController>();
  final Athlete_payment_Controller athlete_payment_controller=Get.find<Athlete_payment_Controller>();
  final Club_payment_Controller club_payment_controller=Get.find<Club_payment_Controller>();
  final Promocode_payment_Controller promocode_payment_controller=Get.find<Promocode_payment_Controller>();

  @override
  void initState() {
   getspeciality_controller.GetspecialityApi(context);
   get_sport_controller.GetsportApi(context);
   getall_billing_controller.GetbillingstateApi(context);
   getall_sport_controller.GetSportApi(context);
   getall_promocode_controller.GetPromocodeApi(context);
   getall_subscription_controller.GetSubscripionApi(context);
   getall_contact_controller.GetContactApi(context);
   statelistController.StatelistApi(context);
   getallAthleteController.GetallathleteApi(context);
   getProfileController.GetProfileApi(context);
   citylistController.GetCitylistApi(context);
   getAthleteprofileController.GetAthleteprofileApi(context);
   athletesearchController.AthletesearchApi(context,'','','','','','', '');
   coachsearchController.CoachsearchApi(context, sportid, '', '', '');
   clubsearchController.ClubsearchApi(context, sportid,'','','','');
   overallprofileController.OverallprofileApi(context);
   getCoachprofilecountController.GetCoachprofilecountApi(context);
   getClubprofilecountController.GetClubprofilecountApi(context);
   athlete_payment_controller.AthleteReportApi(context, '', '', '', '', '', '', '', '', '');
   club_payment_controller.ClubReportApi(context,'','','','','','','','','');
   promocode_payment_controller.PromocodeReportApi(context, '', '', '', '', '');
   List getimagedata=getProfileController.getprofiledata[0]['galleries']??[];
   var profileimage=getimagedata.firstWhere((element)=>element['fileType']=="admin Profile",orElse: ()=>{'fileLocation':''})['fileLocation'];
   adminprofile=profileimage??'';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      // floatingActionButton: FloatingActionButton(
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(30)
      //   ),
      //   backgroundColor: Colors.blue.shade500,
      //   onPressed: (){},
      //   child: const Icon(CupertinoIcons.chat_bubble_text,color: Colors.white,),),
      drawer: Drawer(
        width: displaywidth(context)*0.90,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:50.0,bottom: 20.0),
              child: Container(
                color: Colors.grey.shade200,
                child:  Padding(
                  padding: const EdgeInsets.symmetric(vertical:12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Row(
                          children: [
                              adminprofile==null?
                                  const CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.grey,
                                    child: Icon(Icons.person,color: Colors.white,),
                                  )
                                  : CircleAvatar(
                              radius: 45,
                              backgroundImage: NetworkImage(adminprofile??''),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:12.0),
                              child: Obx(()=>Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(getProfileController.getprofiledata[0]['firstName']??'',style: drawertxt,),
                                    Text(getProfileController.getprofiledata[0]['email']??'',style: drawertxt1,),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      TextButton(onPressed: (){
                        Get.to(const Profile_edit_screen());
                      }, child: Text("View",style: drawertxt1,))
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              // height: displayheight(context)*0.72,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    drawer_listtile(const home_screen(), CupertinoIcons.house, "Dashboard"),
                    drawer_listtile(const ChangepasswordScreen(), CupertinoIcons.lock_fill, "Change Password"),
                    drawer_listtile(const add_sport_data(), Icons.sports_handball_rounded, "Sport"),
                    drawer_listtile(const speciality_screen(), Icons.sports, "Speciality"),
                    drawer_listtile(const promocode_screen(), Icons.confirmation_number, "Promo Code"),
                    drawer_listtile(const SubscriptionScreen(), Icons.notifications, "Subscription"),
                    drawer_listtile(const billing_state(), CupertinoIcons.location_solid, "Billing State"),
                     Padding(
                      padding: const EdgeInsets.symmetric(horizontal:10.0,vertical: 4.0),
                       child: ListTile(
                         onTap: (){
                           setState((){
                             paymentbool=!paymentbool!;
                           });
                         },
                        leading: const Icon(Icons.payment,color:Color(0XFF515151)),
                       title:Text("Payments Reports",style: drawertxttitle,),
                         trailing: Icon(paymentbool==false?Icons.arrow_forward_ios_rounded:Icons.keyboard_arrow_down,color: Color(0XFF515151),),
                      ),
                    ),
                    paymentbool==true?expandreports():Container(),
                    drawer_listtile(const contact_screen(), CupertinoIcons.phone_fill, "Contacts"),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: InkWell(
                        onTap: (){
                          logout();
                        },
                        child: Container(
                          height: displayheight(context)*0.06,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: textfieldcolor),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Text("Logout",style: drawertxttitle,),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),

      ),
      appBar: AppBar(
        elevation: 0.5,
        shadowColor: Colors.grey,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: Builder(
        builder: (context)=>IconButton(onPressed: ()=>Scaffold.of(context).openDrawer(),icon: Icon(Icons.sort,color: Colors.black,),)),
        title: Text("Dashboard",style: appbartxtbold,),
        actions:  [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              onTap: (){
                Get.to(const Profile_edit_screen());
              },
              child:  CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage("$adminprofile"),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text("Select Sport",style: dashboardtxt,),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: DropdownButtonFormField(
              //     decoration:  InputDecoration(
              //       enabledBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10),
              //         borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
              //       ),
              //       focusedBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10),
              //         borderSide: const BorderSide(color:Color(0xFFD9D9D9)),
              //       ),
              //       border: const OutlineInputBorder(),
              //     ),
              //     value: sportid,
              //     items: get_sport_controller.getsportdata.map((item) {
              //       return DropdownMenuItem(
              //         value: item['id'],
              //         child: Text(item['sportName'],style: inputtxt,),
              //         onTap: (){
              //           setState(() {
              //             Selectedsport=item['sportName'];
              //             sportid=item['id'];
              //           });
              //         },
              //       );
              //     }).toList(),
              //     dropdownColor: Colors.white,
              //     onChanged: (newValue) {
              //       setState(() {
              //         Selectedsport = newValue as String;
              //       });
              //     },
              //
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text("Select State",style: dashboardtxt,),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left:8.0),
              //   child: SizedBox(
              //     height: displayheight(context)*0.08,
              //     child: DropdownButtonFormField(
              //       decoration: const InputDecoration(
              //         enabledBorder: OutlineInputBorder(
              //           borderSide: BorderSide(color: Color(0xFFD9D9D9)),
              //         ),
              //         focusedBorder: OutlineInputBorder(
              //           borderSide: BorderSide(color:Color(0xFFD9D9D9)),
              //         ),
              //         border: OutlineInputBorder(),
              //       ),
              //       value: Selectedsport,
              //       items: agelist.map((item) {
              //         return DropdownMenuItem(
              //           value: item,
              //           child: Text(item,style: inputtxt,),
              //           onTap: (){
              //             setState(() {
              //               Selectedsport=item;
              //             });
              //           },
              //         );
              //       }).toList(),
              //       dropdownColor: Colors.white,
              //       onChanged: (newValue) {
              //         setState(() {
              //           Selectedsport = newValue as String;
              //         });
              //       },
              //
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text("As of Date",style: dashboardtxt,),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left:8.0),
              //   child: SizedBox(
              //     height: displayheight(context)*0.08,
              //     child: DropdownButtonFormField(
              //       decoration: const InputDecoration(
              //         enabledBorder: OutlineInputBorder(
              //           borderSide: BorderSide(color: Color(0xFFD9D9D9)),
              //         ),
              //         focusedBorder: OutlineInputBorder(
              //           borderSide: BorderSide(color:Color(0xFFD9D9D9)),
              //         ),
              //         border: OutlineInputBorder(),
              //       ),
              //       value: Selectedsport,
              //       items: agelist.map((item) {
              //         return DropdownMenuItem(
              //           value: item,
              //           child: Text(item,style: inputtxt,),
              //           onTap: (){
              //             setState(() {
              //               Selectedsport=item;
              //             });
              //           },
              //         );
              //       }).toList(),
              //       dropdownColor: Colors.white,
              //       onChanged: (newValue) {
              //         setState(() {
              //           Selectedsport = newValue as String;
              //         });
              //       },
              //
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: SizedBox(
              //     width: double.infinity,
              //     height: displayheight(context)*0.06,
              //     child: ElevatedButton(
              //       style: ElevatedButton.styleFrom(backgroundColor: secondary,shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(10)
              //       )),
              //       child: Text("Search",style: btntxtwhite,),
              //       onPressed: (){},
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("TOTAL NUMBER OF PROFILES",style: dashboardsubtxt,),
              ),
               Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.2, 0.2),
                        spreadRadius:0.5,
                        blurRadius: 2.0
                    )
                  ]
              ),

              child: Totalprofilecount(),
              ),
            ),
              Athleteprofile(),
              Clubprofile(),
              Coachprofile()


    ]),
    )
    ));
  }

  logout()async{
    final SharedPreferences shref=await SharedPreferences.getInstance();
    return showDialog(context: context, builder: (BuildContext context){
      return  CupertinoAlertDialog(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Are you sure you want to Exit the Connect Athlete Admin!",style: inputtxt,textAlign: TextAlign.center,),
        ),
        actions: [
          CupertinoButton(onPressed: (){
            Get.to(const login_screen());
            shref.remove('sessionid');
          }, child:  Text("Yes",style: drawertxt,)),
          CupertinoButton(onPressed: (){
            Get.back();
          }, child:  Text("No",style: drawertxt,))
        ],
      );
    });

  }

Totalprofilecount(){
    return Obx(() {
      List getimagedata=getProfileController.getprofiledata[0]['galleries']??[];
      var profileimage=getimagedata.firstWhere((element)=>element['fileType']=="admin Profile",orElse: ()=>{'fileLocation':''})['fileLocation'];
      adminprofile=profileimage??'';
     return overallprofileController.overallprofiledata.isEmpty?
         const Center(
           child: CupertinoActivityIndicator(),
         )
         :Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFF303478),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(Icons.groups, color: Colors.white, size: 35,),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ONBOARDED", style: dashboardcardtxt,),
                  Row(
                    children: [
                      Text("Active: ${overallprofileController
                          .overallprofiledata[0]['ActiveProfileCount'] ?? ''}",
                        style: dashboardcardgreentxt,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Inactive: ${overallprofileController.overallprofiledata[0]['InActiveProfileCount']??''}", style: dashboardcardprimarytxt,),
                      ),
                    ],
                  ),
                  Text("Expired: ${overallprofileController.overallprofiledata[0]['ExpiredProfileCount']}", style: dashboardcardredtxt,)
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 45,
                  backgroundColor: secondary,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Center(
                      child: Text("${overallprofileController
                          .overallprofiledata[0]['ActiveProfileCount']+overallprofileController
                          .overallprofiledata[0]['InActiveProfileCount']+overallprofileController
                          .overallprofiledata[0]['ExpiredProfileCount']??''}", style: appbartxtbold,),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      );
    }
    );
}

Athleteprofile(){
    return Obx((){
      return getAthleteprofileController.getathletedata.isEmpty?
          const Center(
            child: CupertinoActivityIndicator(),
          )
          :Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("NUMBER OF ATHLETES",style: dashboardsubtxt,),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.2, 0.2),
                        spreadRadius:0.5,
                        blurRadius: 2.0
                    )
                  ]
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color(0xFF303478),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Icon(Icons.directions_run_outlined,color: Colors.white,size: 35,),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("ONBOARDED",style: dashboardcardtxt,),
                          Row(
                            children: [
                              Text("Active:${getAthleteprofileController.getathletedata[0]['athleteActiveProfile']??''}",style: dashboardcardgreentxt,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("InActive:${getAthleteprofileController.getathletedata[0]['athleteInActiveProfile']??''}",style: dashboardcardprimarytxt,),
                              ),
                            ],
                          ),
                          Text("Expired:${getAthleteprofileController.getathletedata[0]['athleteExpiredProfile']??''}",style: dashboardcardredtxt,)
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 45,
                          backgroundColor:secondary,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white,
                            child: Center(
                              child: Text("${getAthleteprofileController.getathletedata[0]['athleteActiveProfile']+getAthleteprofileController.getathletedata[0]['athleteInActiveProfile']+getAthleteprofileController.getathletedata[0]['athleteExpiredProfile']??''}",style: appbartxtbold,),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        height: displayheight(context)*0.05,
                        width: displaywidth(context)*0.30,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: secondary,shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          )),
                          child: Text("View",style: btntxtwhite,),
                          onPressed: ()async{
                            showloadingdialog(context);
                            await athletesearchController.AthletesearchApi(context, '', '', '', '', '', '', '');
                            Navigator.pop(context);
                            List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(athletesearchController.athletesearchdata[0]);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AthleteReport(data: data,age:'',gender:'',city:'',state:'',sport:'',subscription:'',publish:'')));
                          },
                        )),
                  )
                ],
              ),
            ),
          ),
        ],
      );
    });
}

Coachprofile(){
    return Obx((){
      return getCoachprofilecountController.getcoachprofiledata.isEmpty?
      const Center(
        child: CupertinoActivityIndicator(),
      )
          :Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("NUMBER OF COACHES",style: dashboardsubtxt,),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.2, 0.2),
                        spreadRadius:0.5,
                        blurRadius: 2.0
                    )
                  ]
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color(0xFF303478),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Icon(Icons.person,color: Colors.white,size: 35,),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("ONBOARDED",style: dashboardcardtxt,),
                          Row(
                            children: [
                              Text("Active:${getCoachprofilecountController.getcoachprofiledata[0]['coachActiveProfile']??''}",style: dashboardcardgreentxt,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("InActive:${getCoachprofilecountController.getcoachprofiledata[0]['coachInActiveProfile']??''}",style: dashboardcardprimarytxt,),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 45,
                          backgroundColor:secondary,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white,
                            child: Center(
                              child: Text("${getCoachprofilecountController.getcoachprofiledata[0]['coachActiveProfile']+getCoachprofilecountController.getcoachprofiledata[0]['coachInActiveProfile']??''}",style: appbartxtbold,),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        height: displayheight(context)*0.05,
                        width: displaywidth(context)*0.30,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: secondary,shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          )),
                          child: Text("View",style: btntxtwhite,),
                          onPressed: ()async{
                            showloadingdialog(context);
                            await coachsearchController.CoachsearchApi(context, '', '', '', '');
                            Navigator.pop(context);
                            List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(coachsearchController.coachsearchdata[0]);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => coach_report(data:data,city:'',state:'',sport:'',publish:'')));
                          },
                        )),
                  )
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  Clubprofile() {
    return Obx(() {
      if (getClubprofilecountController.getclubdata.isEmpty) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      } else {
        var academieActiveProfile = getClubprofilecountController.getclubdata[0]['academieActiveProfile'] ?? 0;
        var academieInActiveProfile = getClubprofilecountController.getclubdata[0]['academieInActiveProfile'] ?? 0;
        var academieExpiredProfile = getClubprofilecountController.getclubdata[0]['academieExpiredProfile'] ?? 0;
        var totalProfiles = (academieActiveProfile + academieInActiveProfile + academieExpiredProfile);

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("NUMBER OF CLUB & ACADEMICS", style: dashboardsubtxt),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.2, 0.2),
                      spreadRadius: 0.5,
                      blurRadius: 2.0,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF303478),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Icon(
                                Icons.home_work_outlined,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("ONBOARDED", style: dashboardcardtxt),
                            Row(
                              children: [
                                Text(
                                  "Active: $academieActiveProfile",
                                  style: dashboardcardgreentxt,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "InActive: $academieInActiveProfile",
                                    style: dashboardcardprimarytxt,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Expired: $academieExpiredProfile",
                              style: dashboardcardredtxt,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 45,
                            backgroundColor: secondary,
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.white,
                              child: Center(
                                child: Text(
                                  "$totalProfiles",
                                  style: appbartxtbold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: displayheight(context) * 0.05,
                        width: displaywidth(context) * 0.30,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: secondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text("View", style: btntxtwhite),
                          onPressed: () async {
                            showloadingdialog(context);
                            await clubsearchController.ClubsearchApi(
                              context, '', '', '', '', '',);
                            Navigator.pop(context);
                            List<Map<String, dynamic>> data =
                            List<Map<String, dynamic>>.from(
                                clubsearchController.clubsearchdata[0]);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => club_report(data:data,sport:'',city:'',state:'',subscription:'',publish:''),
                            ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }
    });
  }

  Widget expandreports(){
    List<Map<String,dynamic>> data=List<Map<String,dynamic>>.from(athlete_payment_controller.getathletereports);
    List<Map<String,dynamic>> data1=List<Map<String,dynamic>>.from(club_payment_controller.getclubreports);
    List<Map<String,dynamic>> data2=List<Map<String,dynamic>>.from(promocode_payment_controller.getpromocodereports);
    return Container(
      color: Colors.grey.shade200,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            drawer_listtile(athlete_payments(data: data,), Icons.sports_gymnastics_outlined, "Athlete Reports"),
            drawer_listtile(ClubPaymentscreen(data:data1), Icons.home_work_outlined, "Academic Reports"),
            drawer_listtile(PromocodeReportsscreen(data:data2), Icons.card_giftcard_outlined, "Promo code Reports")
          ],
        ),
      ),
    );
  }

}