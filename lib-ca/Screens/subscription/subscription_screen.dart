import 'package:connect_athlete_admin/Common/Common_size.dart';
import 'package:connect_athlete_admin/Common/Common_textstyle.dart';
import 'package:connect_athlete_admin/Screens/subscription/Addsubscriptionscreen.dart';
import 'package:connect_athlete_admin/Screens/subscription/Getall_subscription_Controller.dart';
import 'package:connect_athlete_admin/Screens/subscription/Viewsubscription_screen.dart';
import 'package:connect_athlete_admin/Widget/appbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Common/Common Color.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {

  int?selectedindex;

  final Getall_subscription_Controller getall_subscription_controller=Get.find<Getall_subscription_Controller>();

  @override
  void initState() {
getall_subscription_controller.GetSubscripionApi(context);
super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar_widget("Subscription"),
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
                  Text("Subscription Plans", style: subscriptiontxt),
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
                        Get.to(const Addsubscriptionscreen());
                      },
                      child: Text("+ Add Subscription", style: subscriptionbtntxtwhite),
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
                          child: Text("Plan Name", style: listheadingtxt),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              width: displaywidth(context)*0.20,
                              child: Text("", style: listheadingtxt)),
                        ),

                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: displayheight(context) * 0.70,
                  width: double.infinity,
                  child: Obx(() {
                    return RefreshIndicator(
                      backgroundColor: Colors.white,
                      color: secondary,
                      onRefresh: () async {
                        await getall_subscription_controller.GetSubscripionApi(
                            context);
                      },
                      child: ListView.builder(
                        itemCount: getall_subscription_controller
                            .getsubscriptiondata.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          var data = getall_subscription_controller
                              .getsubscriptiondata[index];
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
                                    SizedBox(
                                      width: displaywidth(context) * 0.30,
                                      child: Center(child: Text(
                                          data['subscriptionName'] ?? '',
                                          style: listsubheadingtxt)),
                                    ),
                                    TextButton(
                                        style: TextButton.styleFrom(
                                            backgroundColor: const Color(
                                                0xFFE4E4FF)),
                                        onPressed: () {
                                          Map<String,dynamic>data=getall_subscription_controller.getsubscriptiondata[index];
                                          Get.to( Viewsubscription_screen(data:data));
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
