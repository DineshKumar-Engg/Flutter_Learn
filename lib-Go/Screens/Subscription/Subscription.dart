import 'package:connect_athelete/Common/Common%20Size.dart';
import 'package:connect_athelete/Common/Common%20Textstyle.dart';
import 'package:connect_athelete/Common/Commonbackground.dart';
import 'package:connect_athelete/Screens/Payment/Payment%20screen.dart';
import 'package:connect_athelete/widget/Backbutton.dart';
import 'package:connect_athelete/widget/Divider.dart';
import 'package:connect_athelete/widget/Shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import '../../Common/Common Color.dart';
import 'Subscription Controller.dart';

class Subscriptionscreen extends StatefulWidget {

   Subscriptionscreen({super.key,});

  @override
  State<Subscriptionscreen> createState() => _SubscriptionscreenState();
}

class _SubscriptionscreenState extends State<Subscriptionscreen> {

  final SubscriptionController subscriptionController=Get.find<SubscriptionController>();

 var color=[
   redgradient,
   bluegradient,
   purplegradient,
   orandegradient,
   primarygradient,
   bluegradient,
   purplegradient,
   redgradient,
 ];
  @override
  void initState() {
    subscriptionController.SubscriptionApi(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          commonbackground(context),
          Positioned(
              child: Padding(
                padding: const EdgeInsets.only(top:45.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    backbutton(),
                    Padding(
                      padding: const EdgeInsets.only(left:10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Subscription",style: requesttxtbold,),
                        ],
                      ),
                    ),

                    Container(
                      height: displayheight(context)*0.76,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top:20.0,left: 20.0,right: 20.0,bottom: 10.0),
                              child:Text("Choose your plan",style: subscriptiontxt,),
                            ),
                            commondivider(const Color(0XFFD9D9D9)),
                             Obx(
                                ()=> Expanded(
                                // height: displayheight(context)*0.64,
                                child: subscriptionController.subscriptiondata.isEmpty?
                                    const Center(child: CircularProgressIndicator(color: primary,),) :
                                     ListView.builder(
                                       shrinkWrap: true,
                                      itemCount: subscriptionController.subscriptiondata.length,
                                      itemBuilder: (context,index){
                                        var subscriptiondata=subscriptionController.subscriptiondata[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: (){
                                            Get.to(Paymentscreen(
                                                subscriptionid:subscriptiondata['id'],
                                                price:subscriptiondata['subscriptionAmount'],
                                                month:subscriptiondata['subscriptionMonth'],
                                                plan:subscriptiondata['subscriptionName']
                                            ));
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              gradient:color[index],
                                              borderRadius: BorderRadius.circular(30)
                                            ),child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                                child: Text("${subscriptiondata['subscriptionName']??''}",style: plantxt,),
                                              ),
                                               Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children:<Widget> [
                                                   Row(
                                                    // mainAxisAlignment: MainAxisAlignment.start,
                                                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                                                    children: [
                                                      Text("\$",style: pricetxt,),
                                                      Text("${subscriptiondata['subscriptionAmount']??''}",style: pricetxt,),
                                                       Text("/ ",style: pricetxt,),
                                                       Text("${subscriptiondata['subscriptionMonth']??''} Month",style: subscridaytxt,),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Icon(Icons.task_alt,color: Colors.white,size: 15,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left:4.0),
                                                        child: SizedBox(
                                                            height:displayheight(context)*0.10,
                                                            width: displaywidth(context)*0.40,
                                                            child: Center(
                                                              child: HtmlWidget('''
                                                              ${subscriptiondata['description']??''}
                                                              ''',textStyle: descplantxt,),
                                                                // child: Text("${subscriptiondata['description']??''},",overflow: TextOverflow.clip,style: descplantxt,)

                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 80.0),
                                                    child: TextButton(onPressed: (){
                                                      Get.to(Paymentscreen(
                                                        subscriptionid:subscriptiondata['id'],
                                                        price:subscriptiondata['subscriptionAmount'],
                                                        month:subscriptiondata['subscriptionMonth'],
                                                        plan:subscriptiondata['subscriptionName']
                                                      ));
                                                    }, child: Row(
                                                      children: [
                                                        Text("Choose plan",style: plantxt,),
                                                        const Icon(Icons.keyboard_arrow_right_sharp,color: Colors.white,)
                                                      ],
                                                    )
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}
