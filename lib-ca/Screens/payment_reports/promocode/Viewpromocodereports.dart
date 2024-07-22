import 'package:connect_athlete_admin/Widget/appbar_widget.dart';
import 'package:flutter/material.dart';
import '../../../Common/Common Color.dart';
import '../../../Common/Common_textstyle.dart';

class Viewpromocodereports extends StatefulWidget {
  Map<String,dynamic> data;
   Viewpromocodereports({super.key,required this.data});

  @override
  State<Viewpromocodereports> createState() => _ViewpromocodereportsState();
}

class _ViewpromocodereportsState extends State<Viewpromocodereports> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: background,
      appBar: appbar_widget("Promo code Details"),
        body:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  decoration:  BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 0.30,
                            offset: Offset(0.2, 0.2),
                            blurRadius: 0.5
                        )
                      ]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical:15.0),
                        child: Container(
                          color: primary,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 4.0),
                            child: Row(
                              children: [
                                Text("Promo code : ",style: btntxtwhite,),
                                Text(widget.data['promocode']['promocodeName']??'',style: listheadingtxt,),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("First Name",style: viewtxt,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(widget.data['user']['firstName']??'',style: inputtxt,),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Last Name",style: viewtxt,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(widget.data['user']['lastName']??'',style: inputtxt,),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Profile",style: viewtxt,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(widget.data['promocode']['role']['roleName']??'',style: inputtxt,),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Discount",style: viewtxt,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("${widget.data['promocode']['discount']??''}",style: inputtxt,),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Start Date",style: viewtxt,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(widget.data['promocode']['startDate']??'',style: inputtxt,),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("End Date",style: viewtxt,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(widget.data['promocode']['endDate']??'',style: inputtxt,),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
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
