import 'package:connect_athlete_admin/Screens/Profile_report/Athlete/Viewathletescreen.dart';
import 'package:connect_athlete_admin/Screens/payment_reports/athlete/Athlete_report_searchscreen.dart';
import 'package:connect_athlete_admin/Screens/payment_reports/athlete/Viewathletereports.dart';
import 'package:connect_athlete_admin/Screens/payment_reports/athlete/athlete_payments_Controller.dart';
import 'package:connect_athlete_admin/Widget/appbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Common/Common Color.dart';
import '../../../Common/Common_size.dart';
import '../../../Common/Common_textstyle.dart';

class athlete_payments extends StatefulWidget {
  List<Map<String,dynamic>> data;
   athlete_payments({super.key,required this.data});

  @override
  State<athlete_payments> createState() => _athlete_paymentsState();
}

class _athlete_paymentsState extends State<athlete_payments> {

  final Athlete_payment_Controller athlete_payment_controller=Get.find<Athlete_payment_Controller>();

  @override
  void initState() {
    // athlete_payment_controller.AthleteReportApi(context, '', '', '', '', '', '', '', '', '');
    super.initState();
  }
  int?selectedindex=0;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar:appbar_widget("Athlete Payment Reports"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: displayheight(context)*0.06,
              child: TextFormField(
                readOnly: true,
                onTap: (){
                  Get.to(const AthleteReportSearchscreen());
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
                    Center(child: Text("Athlete Payment Report Not Found",style: viewtxt,),)
                          : RefreshIndicator(
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
                                            Get.to(Viewathletereport(data: data));
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
