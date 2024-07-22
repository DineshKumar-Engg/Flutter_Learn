import 'package:connect_athlete_admin/Screens/Profile_report/Club/Clubsearchscreen.dart';
import 'package:connect_athlete_admin/Screens/payment_reports/club/Club_report_searchscreen.dart';
import 'package:connect_athlete_admin/Screens/payment_reports/club/ViewClubreport.dart';
import 'package:connect_athlete_admin/Screens/payment_reports/club/club_payment_Controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Common/Common Color.dart';
import '../../../Common/Common_size.dart';
import '../../../Common/Common_textstyle.dart';
import '../../../Widget/appbar_widget.dart';

class ClubPaymentscreen extends StatefulWidget {
  List<Map<String,dynamic>> data;
   ClubPaymentscreen({super.key,required this.data});

  @override
  State<ClubPaymentscreen> createState() => _ClubPaymentscreenState();
}

class _ClubPaymentscreenState extends State<ClubPaymentscreen> {

  final Club_payment_Controller club_payment_controller=Get.find<Club_payment_Controller>();
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
      appBar:appbar_widget("Club & Academic Reports"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: displayheight(context)*0.06,
              child: TextFormField(
                readOnly: true,
                onTap: (){
                  Get.to(const Club_report_searchscreen());
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
                    child: widget.data.isEmpty?
                    Center(child: Text("Club & Academic Payment Reports Not Found",style: viewtxt,),)
                        :
                          RefreshIndicator(
                            onRefresh: ()async{
                              await widget.data;
                            },
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: widget.data.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                var data = widget.data[index];
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
                                          Center(child: Text("${data['firstName']+" "+data['lastName']??''}",style: listsubheadingtxt,)),
                                          TextButton(
                                              style: TextButton.styleFrom(
                                                  backgroundColor: const Color(
                                                      0xFFE4E4FF)),
                                              onPressed: () {
                                                List gettrasction=widget.data[index]['transactionhistories']??'';
                                                List <Map<String,dynamic>> data=gettrasction.cast<Map<String, dynamic>>();
                                                print(data);
                                                Get.to(Viewclubreport(data: data));
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
