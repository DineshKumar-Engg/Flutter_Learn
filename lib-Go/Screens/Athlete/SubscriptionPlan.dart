import 'package:connect_athelete/Screens/Subscription/Subscription.dart';
import 'package:connect_athelete/Services/Transaction%20service/CurrentplanController.dart';
import 'package:connect_athelete/Services/Transaction%20service/Subscription_Api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Common/Common Color.dart';
import '../../Common/Common Textstyle.dart';
import '../../widget/Appbar.dart';

class SubscriptionPlanscreen extends StatefulWidget {
  const SubscriptionPlanscreen({super.key});

  @override
  State<SubscriptionPlanscreen> createState() => _SubscriptionPlanscreenState();
}

class _SubscriptionPlanscreenState extends State<SubscriptionPlanscreen> {

  final Currentplancontroller currentplancontroller=Get.find<Currentplancontroller>();
  DateTime liveDate = DateTime.now();
  String?enddate;
  int?finalenddate;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');


  @override
  void initState(){
    currentplancontroller.CurrentplanApi(context);
    enddate=currentplancontroller.currentplandata[0]['endDate']??'';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DateTime birthday = DateTime.parse(enddate!);
    final String formattedLiveDate = formatter.format(liveDate);
    final int dateDifference = birthday.difference(liveDate).inDays;

    print(dateDifference);
    return  Scaffold(
      backgroundColor: background,
      appBar: appbarwidget("Subscription Plan Details"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:15.0,bottom: 10.0),
                  child: Text("Your Current Plan ",style: drawertxt1,),
                ),
                currentplan(),
                Padding(
                  padding: const EdgeInsets.only(top:12.0),
                  child: Container(
                    width: double.infinity,
                    decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: newyellow,
                        boxShadow:const [
                          BoxShadow(
                            color: Color.fromRGBO(215, 215, 215, 0.83),
                            offset: Offset(1,2),
                            blurRadius: 10,
                            spreadRadius: 0.5,
                          )
                        ]
                    ),
                    child: Padding(
                      padding:const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Your Current Plan ",style: inputtxtwhite,),
                              RichText(text: TextSpan(
                                  style: inputtxtwhite,
                                  text: "Ends in",
                                children: [
                                  dateDifference==0?
                                  TextSpan(text: " Today",style:inputtxtwhitebold )
                                      :
                                  TextSpan(text: " $dateDifference Days",style:inputtxtwhitebold )
                                ]
                              )),
                            ],
                          ),

                          ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.white,shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)
                              )),
                              onPressed: (){
                                Get.to(Subscriptionscreen());
                              }, child:Text("Renew Now",style: secondarysign,))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),

    );
  }

  Widget currentplan(){
    return   Container(
      decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow:const [
            BoxShadow(
              color: Color.fromRGBO(215, 215, 215, 0.83),
              offset: Offset(1,2),
              blurRadius: 10,
              spreadRadius: 0.5,
            )
          ]
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Obx(
              ()=> currentplancontroller.currentplandata.isEmpty?const Center(
            child: CupertinoActivityIndicator(color: primary,),
          ):Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Plan Name : ",style: subscritxtnew,),
                    Text("${currentplancontroller.currentplandata[0]['subscription']['subscriptionName']}",style: subscritxtsubnew,)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Plan Duration : ",style: subscritxtnew,),
                    Text("${currentplancontroller.currentplandata[0]['subscription']['subscriptionMonth']} Month",style: subscritxtsubnew,)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Start Date: ",style: subscritxtnew,),
                    Text("${currentplancontroller.currentplandata[0]['startDate']}",style: subscritxtsubnew,)
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Plan Price : ",style: subscritxtnew,),
                    Text("\$${currentplancontroller.currentplandata[0]['totalAmount']}",style: subscritxtsubnew,)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("End Date : ",style: subscritxtnew,),
                    Text("${currentplancontroller.currentplandata[0]['endDate']}",style: subscritxtsubnew,)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Plan Status : ",style: subscritxtnew,),
                    Text("Activated",style: planactivetxt,)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
