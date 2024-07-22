import 'package:connect_athlete_admin/Screens/promocode/Getall_proocode_Controller.dart';
import 'package:connect_athlete_admin/Screens/promocode/View_promocode.dart';
import 'package:connect_athlete_admin/Screens/promocode/add_promocode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Common/Common Color.dart';
import '../../Common/Common_size.dart';
import '../../Common/Common_textstyle.dart';
import '../../Widget/appbar_widget.dart';

class promocode_screen extends StatefulWidget {
  const promocode_screen({super.key});

  @override
  State<promocode_screen> createState() => _promocode_screenState();
}

class _promocode_screenState extends State<promocode_screen> {
  int?selectedindex;

  final Getall_promocode_Controller getall_promocode_controller=Get.find<Getall_promocode_Controller>();

  @override
  void initState() {
 getall_promocode_controller.GetPromocodeApi(context);
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar_widget("Promo Code"),
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
                  Text("Promo Code", style: subscriptiontxt),
                  SizedBox(
                    height: displayheight(context) * 0.05,
                    width: displaywidth(context) * 0.40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Get.to(const add_promocode());
                      },
                      child: Text("+ Add Promocode", style: subscriptionbtntxtwhite),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  width: double.infinity,
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
                          child: Text("S.No", style: listheadingtxt),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text("Code Value", style: listheadingtxt)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: SizedBox(
                              width: displaywidth(context)*0.25,
                              child: Text("", style: listheadingtxt))),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: displayheight(context) * 0.75,
                  width: double.infinity,
                  child: Obx(() {
                    return RefreshIndicator(
                      backgroundColor: Colors.white,
                      color: secondary,
                      onRefresh: () async {
                        await getall_promocode_controller.GetPromocodeApi(
                            context);
                      },

                      child: ListView.builder(
                        itemCount: getall_promocode_controller.getpromocodedata
                            .length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          var data = getall_promocode_controller
                              .getpromocodedata[index];
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedindex = index;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: selectedindex == index ? const Color(
                                    0XFFD4D5E2) : Colors.white,
                                border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey.shade200),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: displaywidth(context) * 0.10,
                                      child: Center(child: Text("${index + 1}.",
                                          style: listsubheadingtxt)),
                                    ),
                                    Center(child: Text(data['promocodeName'],
                                        style: listsubheadingtxt)),
                                    TextButton(
                                        style: TextButton.styleFrom(
                                            backgroundColor: const Color(
                                                0xFFE4E4FF)),
                                        onPressed: () {
                                          Map<String,dynamic> data=getall_promocode_controller.getpromocodedata[index];
                                          Get.to( View_promocodescreen(data:data));
                                        },
                                        child: Text(
                                          "View Details", style: viewbtntxt,))
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
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
