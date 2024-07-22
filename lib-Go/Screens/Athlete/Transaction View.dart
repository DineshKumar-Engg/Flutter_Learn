import '../../Common/Common Color.dart';
import '../../Common/Common Size.dart';
import '../../Common/Common Textstyle.dart';
import '../../widget/Appbar.dart';
import 'package:flutter/material.dart';


class TransactionViewscreen extends StatefulWidget {
  final Map<String, dynamic> transactiondata;
  TransactionViewscreen( {super.key,required this.transactiondata});

  @override
  State<TransactionViewscreen> createState() => _TransactionViewscreenState();
}

class _TransactionViewscreenState extends State<TransactionViewscreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:background,
      appBar: appbarwidget("Transaction History"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: displayheight(context)*0.50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color:Colors.black.withOpacity(0.10000000149011612)),
            borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                  Padding(
                    padding: const EdgeInsets.only(top:10.0),
                    child: Container(
                      height: displayheight(context)*0.06,
                      width: displaywidth(context)*0.60,
                      decoration: const BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(25)
                        )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Plan Name : ",style: transtxtview1,),
                          Text(widget.transactiondata['subscriptionName']??'',style: transtxtview2,)
                        ],
                      ),
                    ),
                  ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Text("Plan Date : ",style: transtxt3,),
                    Text("${widget.transactiondata['startDate']??''}",style: transtxt4,),
                    Text(" - ",style: transtxt4,),
                    Text("${widget.transactiondata['endDate']??''}",style: transtxt4,)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Text("Plan Duration : ",style: transtxt3,),
                    Text("${widget.transactiondata['subscriptionMonth']??''} Month ",style: transtxt5,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Text("Plan Status : ",style: transtxt3,),
                    Text("${widget.transactiondata['paymentStatus']??''}",style: pricetxtnew,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Text("Mode of Payment : ",style: transtxt3,),
                    Text("${widget.transactiondata['modeOfPayment']??''}",style: transtxt4,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Price",style: transtxt5,),
                    Text(" \$ ${widget.transactiondata['subtotalAmount']}",style: transtxt5,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Tax",style: transtxt5,),
                    Text("\$ ${widget.transactiondata['taxAmount']??''}",style: transtxt5,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Service Fee",style: transtxt5,),
                    Text(" \$ ${widget.transactiondata['serviceTax']}",style: transtxt5,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Processing Fee",style: transtxt5,),
                    Text(" \$ ${widget.transactiondata['processingTax']}",style: transtxt5,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Convenience Fee",style: transtxt5,),
                    Text(" \$ ${widget.transactiondata['convenienceTax']}",style: transtxt5,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Discount",style: transtxt5,),
                    Text("${widget.transactiondata['discount']??00}",style: transtxt5,),
                  ],
                ),
              ),
              Container(
                height: displayheight(context)*0.07,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Total Amount ",style: transtxtview1,),
                      Text(" \$ ${widget.transactiondata['totalAmount']}",style: transtxtview1,),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
