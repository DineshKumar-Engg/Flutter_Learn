import 'package:connect_athlete_admin/Screens/Contact/Getall_Contact_Controller.dart';
import 'package:connect_athlete_admin/Screens/Contact/view_contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Common/Common Color.dart';
import '../../Common/Common_size.dart';
import '../../Common/Common_textstyle.dart';
import '../../Widget/appbar_widget.dart';

class contact_screen extends StatefulWidget {
  const contact_screen({super.key});

  @override
  State<contact_screen> createState() => _contact_screenState();
}

class _contact_screenState extends State<contact_screen> {
  int?selectedindex;

  final Getall_contact_Controller getall_contact_controller=Get.find<Getall_contact_Controller>();

  @override
  void initState() {
    getall_contact_controller.GetContactApi(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar_widget("Contact"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Header with "Subscription Plans" and "Add Subscription" button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Contact", style: subscriptiontxt),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  width:double.infinity,
                  decoration: const BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: displaywidth(context) * 0.10,
                            child: Text("S.No", style: listheadingtxt),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: displaywidth(context) * 0.30,
                            child: Center(child: Text("Name", style: listheadingtxt)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: displaywidth(context) * 0.30,
                            child: Center(child: Text("", style: listheadingtxt)),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: SizedBox(
                        //     width: displaywidth(context) * 0.35,
                        //     child: Center(child: Text("Contact Number", style: listheadingtxt)),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: SizedBox(
                        //     width: displaywidth(context) * 0.35,
                        //     child: Center(child: Text("Email", style: listheadingtxt)),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: SizedBox(
                        //     width: displaywidth(context) * 0.50,
                        //     child: Center(child: Text("Message", style: listheadingtxt)),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: getall_contact_controller.getcontactdata.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      var data=getall_contact_controller.getcontactdata[index];
                      return InkWell(
                        onTap: (){
                          setState(() {
                            selectedindex=index;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: selectedindex==index?const Color(0XFFD4D5E2):Colors.white,
                            border: Border(
                              bottom: BorderSide(color: Colors.grey.shade200),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: displaywidth(context) * 0.15,
                                  child: Center(child: Text("${index + 1}.", style: listsubheadingtxt)),
                                ),
                                Center(child: Text(data['firstname']+" "+data['lastname']??'', style: listsubheadingtxt)),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: const Color(
                                            0xFFE4E4FF)),
                                    onPressed: () {
                                      Map<String,dynamic> data=getall_contact_controller.getcontactdata[index];
                                      Get.to( view_contact_screen(data:data));
                                    },
                                    child: Text(
                                      "View Details", style: viewbtntxt,))
                                // SizedBox(
                                //   width: displaywidth(context) * 0.35,
                                //   child: Text(data['lastname']??'', style: listsubheadingtxt),
                                // ),
                                // SizedBox(
                                //   width: displaywidth(context) * 0.35,
                                //   child: Text(data['phone']??'', style: listsubheadingtxt),
                                // ),
                                // SizedBox(
                                //   width: displaywidth(context) * 0.40,
                                //   child: Center(child: Text(data['email']??'', style: listsubheadingtxt)),
                                // ),
                                // SizedBox(
                                //   width: displaywidth(context) * 0.52,
                                //   child: Center(child: Text(data['message']??'', style: listsubheadingtxt)),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
