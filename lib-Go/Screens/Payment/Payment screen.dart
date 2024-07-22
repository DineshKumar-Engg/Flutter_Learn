import 'package:connect_athelete/Common/Common%20Textstyle.dart';
import 'package:connect_athelete/Common/Commonbackground.dart';
import 'package:connect_athelete/Screens/Payment/Billing%20screen.dart';
import 'package:connect_athelete/Screens/Payment/Payment%20Controller.dart';
import 'package:connect_athelete/widget/Backbutton.dart';
import 'package:connect_athelete/widget/Container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Common/Common Color.dart';
import '../../Common/Common Size.dart';
import '../../widget/Snackbar.dart';

class Paymentscreen extends StatefulWidget {
  String price,plan;
  int subscriptionid,month;
   Paymentscreen({super.key,required this.price, required this.subscriptionid,required this.month,required this.plan});

  @override
  State<Paymentscreen> createState() => _PaymentscreenState();
}

class _PaymentscreenState extends State<Paymentscreen> {

  final TextEditingController cardnumbercontroller=TextEditingController();
  final TextEditingController cardnamecontroller=TextEditingController();

  final PaymentController paymentController=Get.find<PaymentController>();
  int pay=0;
  int ?stateid;
  bool status = false;
  String ?Selectedstate;
  @override
  void initState() {
  paymentController.PaymentApi(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          commonbackground(context),
          Positioned(
              child: Padding(
                padding: const EdgeInsets.only(top:50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         backbutton(),
                          Padding(
                            padding: const EdgeInsets.only(top:8.0),
                            child: Text("Payment",style: paymenttitle,),
                          ),
                          SizedBox(
                            width: displaywidth(context)*0.10,
                          )
                        ],
                      ),
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        commoncontainer(displayheight(context)*0.55,
                            Padding(
                              padding: const EdgeInsets.only(top:20.0,left: 8.0,right: 8.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Billing State",style: billtittle,),
                                    ),
                                    bankscreen(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("Plan Name",style: paymentsubtxt,),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("Duration",style: paymentsubtxt,),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("Total",style: paymentsubtxt,),
                                            ),
                                
                                
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(widget.plan,style: paymentsubtxt1,),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("${widget.month} month",style: paymentsubtxtgreen,),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  const Icon(Icons.attach_money,color: Color(0xFF3B3551),),
                                                  Text("${widget.price}",style: paymentsubtxttitle,),
                                                ],
                                              ),
                                            )
                                
                                          ],
                                        ),
                                
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        height: displayheight(context)*0.06,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: primary,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10)
                                                )
                                            ),
                                            onPressed: (){
                                              if(Selectedstate==null){
                                                StackDialog.show("Select State", "Select Your State To Make Payment", Icons.info, Colors.red);
                                              }
                                              else{
                                                Get.to(Billingscreen(
                                                    subscriptionid:widget.subscriptionid,
                                                    state:stateid as int,
                                                    plan:widget.plan,
                                                  month:widget.month
                                                ));
                                              }
                                
                                            }, child: Center(child: Text("Continue",style: btntxtwhite,),)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
  Widget bankscreen(){
    return Obx(
        ()=>Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:12.0),
                  child: Text("Select State",style:banksubtxt,),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 18.0),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      hintText: "Select State",
                      hintStyle: textfieldhint,
                      enabledBorder:  OutlineInputBorder(
                          borderSide:const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      focusedBorder:  OutlineInputBorder(
                          borderSide:const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      border: const OutlineInputBorder(),
                    ),
                    value: stateid,
                    items: paymentController.paymentdata.map((item) {
                      return DropdownMenuItem(
                        value: item['id'],
                        child: Text(item['stateName'],style: textfieldtxt,),
                        onTap: (){
                          setState(() {
                            Selectedstate=item['stateName'];
                            stateid=item['id'];

                          });
                        },
                      );
                    }).toList(),
                    dropdownColor: Colors.white,
                    onChanged: (newValue) {
                      setState(() {
                        Selectedstate = newValue as String;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }


}
