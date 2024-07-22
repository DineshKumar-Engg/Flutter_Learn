import 'package:flutter/material.dart';

import '../../../Common/Common Color.dart';
import '../../../Common/Common_size.dart';
import '../../../Common/Common_textstyle.dart';
import '../../../Widget/appbar_widget.dart';

class Viewclubreport extends StatefulWidget {
  List <Map<String,dynamic>>data;
   Viewclubreport({super.key,required this.data});

  @override
  State<Viewclubreport> createState() => _ViewclubreportState();
}

class _ViewclubreportState extends State<Viewclubreport> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: background,
      appBar: appbar_widget("Transaction History"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: displayheight(context)*0.90,
          width: double.infinity,
          child: widget.data.isEmpty?
          Center(
            child: Text("No Transaction History Found",style: viewtxt,),
          )
              :ListView.builder(
              itemCount: widget.data.length,
              itemBuilder: (BuildContext context,int index){
                var data=widget.data[index];
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10)
                              )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Text("Transaction History -${index + 1}",style: btntxtwhite,)),
                          )),
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.white
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Text("Payment ID ",style: loginhinttxt,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Text("Subscription Plan ",style: loginhinttxt,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Text("Transaction ID ",style: loginhinttxt,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Text("Payment Status ",style: loginhinttxt,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Text("Tax Amount ",style: loginhinttxt,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Text("Processing Fee ",style: loginhinttxt,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Text("Convenience Fee ",style: loginhinttxt,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Text("Service Fee ",style: loginhinttxt,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Text("Tax Percentage ",style: loginhinttxt,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Text("Discount ",style: loginhinttxt,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Text("Mode of Payment ",style: loginhinttxt,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Text("End Date of Plan ",style: loginhinttxt,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Text("Subtotal Amount ",style: loginhinttxt,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Text("Total Amount ",style: loginhinttxt,),
                                  ),

                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Text(": ${data['id']??''}",style: viewtxt,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Text(": ${data['subscriptionName']??''}",style: viewtxt,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Text(": ${data['paymentTransactionId']??''}",style: viewtxt,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Text(": ${data['paymentStatus']??''}",style: viewtxt,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Text(": ${data['taxAmount']??''}",style: viewtxt,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Text(": \$${data['processingTax']??''}",style: viewtxt,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Text(": \$${data['convenienceTax']??''}",style: viewtxt,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Text(": \$${data['serviceTax']??''}",style: viewtxt,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Text(": ${data['taxPercentage']??''}",style: viewtxt,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Text(": ${data['discount']??''}",style: viewtxt,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Text(": ${data['modeOfPayment']??''}",style: viewtxt,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Text(": ${data['endDate']??''}",style: viewtxt,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Text(": \$${data['subtotalAmount']??''}",style: viewtxt,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Text(": \$${data['totalAmount']??''}",style: viewtxt,),
                                  ),

                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                );
              }),
        ),
      ),
    );
  }
}
