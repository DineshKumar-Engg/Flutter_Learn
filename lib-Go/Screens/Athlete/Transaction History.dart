import 'package:flutter/cupertino.dart';

import '../../Common/Common Color.dart';
import '../../Common/Common Size.dart';
import '../../Common/Common Textstyle.dart';
import '../../Services/Transaction service/Transaction_History_Api.dart';
import '../../widget/Appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Transaction View.dart';

class TransactionHistoryscreen extends StatefulWidget {
  const TransactionHistoryscreen({super.key});

  @override
  State<TransactionHistoryscreen> createState() => _TransactionHistoryscreenState();
}

class _TransactionHistoryscreenState extends State<TransactionHistoryscreen> {


  final TransactionHistoryController transactionHistoryController=Get.find<TransactionHistoryController>();
  @override
  void initState(){
    transactionHistoryController.TransactionHistoryApi(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:background,
      appBar: appbarwidget("Transaction History"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 2.0),
        child: SizedBox(
          height: displayheight(context)*1,
          child: Obx(
              ()=> transactionHistoryController.gettransactionhistorydata.isEmpty?const Center(
                child: CupertinoActivityIndicator()
              )
                  :RefreshIndicator(
                   backgroundColor:primary,
                   color: Colors.white,
                   onRefresh: ()async{
                     await transactionHistoryController.TransactionHistoryApi(context);
                   },
                    child: ListView.builder(
                     itemCount:transactionHistoryController.gettransactionhistorydata.length,
                     itemBuilder: (BuildContext context,int index){
                       return SizedBox(
                                    height: displayheight(context)*0.09,
                                    width: double.infinity,
                        child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                    ),
                    shadowColor: Colors.grey,
                    elevation: 1,
                    surfaceTintColor: Colors.transparent,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text("Plan Name : ",style: transtxtnew,),
                              Text(transactionHistoryController.gettransactionhistorydata[index]['subscription']['subscriptionName']??"Basic plan",style: transtxtnew,)
                            ],
                          ),
                          Row(
                            children: [
                              Text("Price",style: transtxtnew,),
                              Text(":\$${transactionHistoryController.gettransactionhistorydata[index]['totalAmount']}",style: transtxtnew,)
                            ],
                          ),
                          TextButton(
                              style: TextButton.styleFrom(backgroundColor: const Color(0xFFE4E4FF)),
                              onPressed: (){
                                Map<String, dynamic> selectedTransaction = transactionHistoryController.gettransactionhistorydata[index];
                                Get.to( TransactionViewscreen(transactiondata:selectedTransaction,));
                              }, child: Text("View Details",style: viewbtntxt,))
                        ],
                      ),
                    ),
                                    ),
                                  );
                                }),
                  ),
          ),
        ),
      ),

    );
  }
}
