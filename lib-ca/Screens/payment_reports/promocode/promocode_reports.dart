import 'package:connect_athlete_admin/Screens/payment_reports/promocode/Viewpromocodereports.dart';
import 'package:connect_athlete_admin/Screens/payment_reports/promocode/promocode_payment_searchscreen.dart';
import 'package:connect_athlete_admin/Screens/payment_reports/promocode/promocode_payments_Controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Common/Common Color.dart';
import '../../../Common/Common_size.dart';
import '../../../Common/Common_textstyle.dart';
import '../../../Widget/appbar_widget.dart';

class PromocodeReportsscreen extends StatefulWidget {
  List<Map<String,dynamic>> data;
   PromocodeReportsscreen({super.key,required this.data});

  @override
  State<PromocodeReportsscreen> createState() => _PromocodeReportsscreenState();
}

class _PromocodeReportsscreenState extends State<PromocodeReportsscreen> {

  final Promocode_payment_Controller promocode_payment_controller=Get.find<Promocode_payment_Controller>();

  int selectedindex=0;
  @override
  void initState() {
widget.data;
super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar:appbar_widget("Promo code Reports"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: displayheight(context)*0.06,
              child: TextFormField(
                readOnly: true,
                onTap: (){
                  Get.to(const Promocode_payment_searchscreen());
                },
                decoration: InputDecoration(
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    prefixIcon: const Icon(CupertinoIcons.search),
                    hintText: "Search here",
                    hintStyle: inputtxt,
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(15)
                    )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
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
                              width: displaywidth(context) * 0.12,
                              child: Text("S.No", style: listheadingtxt),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: displaywidth(context) * 0.20,
                              child: Text("Name", style: listheadingtxt),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: displaywidth(context) * 0.20,
                              child: Text("", style: listheadingtxt),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: displayheight(context) * 0.74,
                    width: double.infinity,
                    child: promocode_payment_controller.getpromocodereports.isEmpty?
                    Center(child: Text("No Athlete Profile Found",style: viewtxt,),)
                        :Obx(
                          ()=>
                          RefreshIndicator(
                            onRefresh: ()async{
                              await promocode_payment_controller.PromocodeReportApi(context, "", "", "", "", "") ;

                            },
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: promocode_payment_controller.getpromocodereports.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                var data = promocode_payment_controller.getpromocodereports[index];
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedindex = index;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: selectedindex == index ? const Color(0XFFD4D5E2) : Colors.white,
                                      border: Border(
                                        bottom: BorderSide(color: Colors.grey.shade200),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical:4.0,horizontal: 4.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: displaywidth(context)*0.10,
                                            child: Text("${index+1}.",style: listsubheadingtxt,),
                                          ),
                                          Center(child: Text("${data['user']['firstName']+""
                                              " "+data['user']['lastName']??''}",style: listsubheadingtxt,)),
                                          TextButton(
                                              style: TextButton.styleFrom(
                                                  backgroundColor: const Color(
                                                      0xFFE4E4FF)),
                                              onPressed: () {
                                                Map<String,dynamic> data=promocode_payment_controller.getpromocodereports[index];
                                                print(data);
                                                Get.to(Viewpromocodereports(data: data));
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
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
