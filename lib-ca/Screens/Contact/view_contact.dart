import 'package:connect_athlete_admin/Common/Common%20Color.dart';
import 'package:connect_athlete_admin/Common/Common_textstyle.dart';
import 'package:connect_athlete_admin/Widget/appbar_widget.dart';
import 'package:flutter/material.dart';

class view_contact_screen extends StatefulWidget {
  Map<String,dynamic> data;
   view_contact_screen({super.key,required this.data});

  @override
  State<view_contact_screen> createState() => _view_contact_screenState();
}

class _view_contact_screenState extends State<view_contact_screen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: background,
      appBar: appbar_widget("Contact Details"),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15)
            ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("First Name",style:viewtxt ,),
                              Text(widget.data['firstname']??'',style: inputtxt,)
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("Last Name",style:viewtxt ,),
                              Text(widget.data['lastname']??'',style: inputtxt,)
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Email ID",style:viewtxt ,),
                          Text(widget.data['email']??'',style: inputtxt,)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Mobile Number",style:viewtxt ,),
                          Text(widget.data['phone']??'',style: inputtxt,)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Message",style:viewtxt ,),
                          Text(widget.data['message']??'',style: inputtxt,)
                        ],
                      ),
                    )

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
