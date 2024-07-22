import 'package:animate_do/animate_do.dart';
import 'package:connect_athelete/Screens/Login/Loginscreen.dart';
import 'package:connect_athelete/Screens/Subscription/ActivatePlanController.dart';
import 'package:connect_athelete/Services/Transaction%20service/CurrentplanController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Common/Common Color.dart';
import '../../Common/Common Size.dart';
import '../../Common/Common Textstyle.dart';
import '../../Common/Commonbackground.dart';
import '../Athlete/Athlete Homescreen.dart';
import '../Club/Club Homescreen.dart';
import '../Coach/Coach Homescreen.dart';

class Paymentsucessalert extends StatefulWidget {
  int?subscriptionid;
   Paymentsucessalert({super.key,required this.subscriptionid});

  @override
  State<Paymentsucessalert> createState() => _PaymentsucessalertState();
}

class _PaymentsucessalertState extends State<Paymentsucessalert> {

  final ActivatePlanController activatePlanController=Get.find<ActivatePlanController>();

  String?userid,enddate;
  DateTime liveDate = DateTime.now();
  int?finalenddate;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  @override
  void initState() {
    super.initState();
    // enddate=currentplancontroller.currentplandata[0]['endDate']??'';
  }
  @override
  Widget build(BuildContext context) {
    // final DateTime birthday = DateTime.parse(enddate!);
    // final String formattedLiveDate = formatter.format(liveDate);
    // final int dateDifference = birthday.difference(liveDate).inDays;
    // print(dateDifference);

    return WillPopScope(
      onWillPop: () =>_backpress(),
      child: Scaffold(
        body:Stack(
          clipBehavior: Clip.none,
          children: [
            commonbackground(context),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
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
                              child: Text("Your Subscription Has Been Activated",style: cardtxt,textAlign: TextAlign.center,),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: SizedBox(
                                height:displayheight(context)*0.06,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(backgroundColor: newyellow,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)
                                      )
                                    ),
                                    onPressed: ()async{
                                      final SharedPreferences shref=await SharedPreferences.getInstance();
                                      userid=shref.getString("sessionid");
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> userid=="athlete"?
                                      const AthleteHomescreen()
                                          :userid=="coach"?
                                      const CoachHomescreen():
                                      userid=="club"?
                                      const ClubsHomescreen():
                                      const Loginscreen()));
                                      // if(dateDifference > 0){
                                      //   print("Current Plan Not Ended");
                                      // }else{
                                      //   activatePlanController.ActivatePlanApi(context, widget.subscriptionid);
                                      //   print("Plan Activated from successalert");
                                      // }
                                    }, child: Center(child: Text("Continue",style: btntxtwhite,),)),
                              ),
                            ),
                            const SizedBox(height: 20,)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  _backpress(){
    // return showDialog(
    //     context: context, builder: (BuildContext context){
    //   return AlertDialog(
    //     backgroundColor: Colors.white,
    //     surfaceTintColor: Colors.transparent,
    //     title: Text("Are you sure you want to Exit Connect Athlete!",style:drawertxt1,textAlign: TextAlign.center,),
    //     actions: [
    //       TextButton(onPressed: (){Navigator.pop(context,false);}, child: Text("No",style: drawertxt,)),
    //       TextButton(onPressed: (){Navigator.pop(context,true);}, child: Text("Yes",style: drawertxt,))
    //     ],
    //   );
    // });
  }
}
