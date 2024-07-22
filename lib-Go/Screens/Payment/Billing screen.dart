import 'dart:convert';
import 'package:connect_athelete/Common/Common%20Textstyle.dart';
import 'package:connect_athelete/Common/Commonbackground.dart';
import 'package:connect_athelete/Screens/Payment/Checkout%20Controller.dart';
import 'package:connect_athelete/Screens/Payment/Paymentsucessalert.dart';
import 'package:connect_athelete/Screens/Subscription/ActivatePlanController.dart';
import 'package:connect_athelete/Services/Athlete%20Service/Profile%20Details%20Api.dart';
import 'package:connect_athelete/Services/Promocode%20Api/Promocode%20Controller.dart';
import 'package:connect_athelete/Screens/Subscription/Get%20Subscription%20Controller.dart';
import 'package:connect_athelete/widget/Divider.dart';
import 'package:connect_athelete/widget/Loading.dart';
import 'package:connect_athelete/widget/Snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Common/Common Color.dart';
import '../../Common/Common Size.dart';
import '../../Services/Payment service/Payment Api.dart';
import '../../Services/Transaction service/CurrentplanController.dart';

class Billingscreen extends StatefulWidget {
  int state,subscriptionid,month;
  String?plan;

   Billingscreen({super.key,required this.state, required  this.subscriptionid,required this.month,required this.plan});

  @override
  State<Billingscreen> createState() => _BillingscreenState();
}

class _BillingscreenState extends State<Billingscreen> {

  final TextEditingController promocontroller=TextEditingController();

  final CheckoutController checkoutController=Get.find<CheckoutController>();
  final GetSubscriptionByid getSubscriptionByid=Get.find<GetSubscriptionByid>();
  final PromoCodeController promoCodeController=Get.find<PromoCodeController>();
  final SquarePaymentController squarePaymentController=Get.find<SquarePaymentController>();
  final Currentplancontroller currentplancontroller=Get.find<Currentplancontroller>();

  // final ActivatePlanController activatePlanController=Get.find<ActivatePlanController>();
  double?newsubscriptionamount,newtax,newservicetax,newprocessingtax,newconvenicetax,newfinalamount,grandtotalamount,finaltaxcalculated;
  bool _isLoading = false;
  double promoamount=0;
  double getpromocodeamount=0;
  String ?roledata,promocodeid;
  int?stripepaymentamount;

  Future<void> totalamount(void Function(double) callback) async {
    double subscriptionamount = double.parse("${getSubscriptionByid.getsubscriptiondata[0]['subscriptionAmount'] ?? '0'}");
    newsubscriptionamount = subscriptionamount;

    double tax = double.parse("${checkoutController.checkoutdata[0]['tax'] ?? '0'}");
    newtax = tax;

    double servicetax = double.parse("${getSubscriptionByid.getsubscriptiondata[0]['serviceTax'] ?? '0'}");
    newservicetax = servicetax;

    double processingtax = double.parse("${getSubscriptionByid.getsubscriptiondata[0]['processingTax'] ?? '0'}");
    newprocessingtax = processingtax;

    double conveniencetax = double.parse("${getSubscriptionByid.getsubscriptiondata[0]['convenienceTax'] ?? '0'}");
    newconvenicetax = conveniencetax;

    // Calculate the total amount
    double finalamount = subscriptionamount + tax + servicetax + processingtax + conveniencetax;
    newfinalamount = finalamount;

    // Calculate the tax based on the final amount
    double calculatetax = newfinalamount! * (newtax! / 100);
    finaltaxcalculated = calculatetax;

    // Adjust the grand total amount with promo code if applicable
    double getpromoamount = promoamount.toDouble();
    grandtotalamount = newfinalamount! - getpromoamount;

    setState(() {
      newfinalamount = finalamount;
      grandtotalamount = (finalamount?.toDouble()??0) - getpromocodeamount;});

        int getgrandtotalamount=(grandtotalamount!*100).toInt();
        stripepaymentamount=(getgrandtotalamount??'') as int?;
    }



  // Future<void> totalamount(void Function(double) callback) async {
  //   double subscriptionamount = double.parse("${getSubscriptionByid.getsubscriptiondata[0]['subscriptionAmount'] ?? ''}");
  //   newsubscriptionamount=subscriptionamount;
  //   double tax = double.parse("${checkoutController.checkoutdata[0]['tax'] ?? ''}");
  //   newtax=tax;
  //   double servicetax = double.parse("${getSubscriptionByid.getsubscriptiondata[0]['serviceTax'] ?? ''}");
  //   newservicetax=servicetax;
  //   double processingtax = double.parse("${getSubscriptionByid.getsubscriptiondata[0]['processingTax'] ?? ''}");
  //   newprocessingtax=processingtax;
  //   double conveniencetax = double.parse("${getSubscriptionByid.getsubscriptiondata[0]['convenienceTax'] ?? ''}");
  //   newconvenicetax=conveniencetax;
  //   double finalamount = subscriptionamount + tax + servicetax + processingtax + conveniencetax;
  //   double getpromoamount=promoamount.toDouble();
  //
  //   double calculatetax = newfinalamount! * (newtax! / 100);
  //     finaltaxcalculated = calculatetax;
  //
  //   setState(() {
  //     newfinalamount = finalamount;
  //     grandtotalamount = (finalamount?.toDouble()??0) - getpromocodeamount;});
  //
  //   int getgrandtotalamount=(grandtotalamount!*100).toInt();
  //   stripepaymentamount=(getgrandtotalamount??'') as int?;
  // }

  void localid()async{
    final SharedPreferences shref=await SharedPreferences.getInstance();
    var getdata=shref.getString('sessionid');
    roledata=getdata??'';
  }
  Future<Map<String, dynamic>?> createPaymentIntent(String amount, String currency) async {
    try {
      final body = {
        'amount': amount,
        'currency': currency,
      };
      final response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        headers: {
          'Authorization': 'Bearer sk_test_51PT4BW2NgzuLDBvzLPCZeJqRy3IpffEZD7wuAwWd1l9Zn8Lw0aDLzAs16ZX6FSKf5DT4MlVaN8lpZtX4LvEwu9Oo00vSzo3QCc',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {'error': jsonDecode(response.body)};
      }
    } catch (error) {
      print(error);
      return {'error': error.toString()};
    }
  }

  Future<void> createpayment(BuildContext context,amount) async {
    try {
      final paymentIntent = await createPaymentIntent('$stripepaymentamount', 'USD');

      if (paymentIntent == null || paymentIntent.containsKey('error')) {
        print("Error creating payment intent: ${paymentIntent?['error']}");
        return;
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['client_secret'],
          customFlow: false,
          style: ThemeMode.dark,
          merchantDisplayName: "Connect Athlete",
        ),
      ).then((_) {
        displayPaymentsheet(context, paymentIntent);
      });
    } catch (error) {
      print(error);
    }
  }

  void displayPaymentsheet(BuildContext context, Map<String, dynamic> paymentIntent) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((_) {
        squarePaymentController.SquarePaymentApi(context,paymentIntent['id'],newsubscriptionamount.toString(),newtax.toString(),
          newservicetax.toString(), newprocessingtax.toString(), newconvenicetax.toString(),
            promoamount.toString(),newfinalamount.toString(),widget.subscriptionid,paymentIntent['payment_method_types'][0],widget.plan,widget.month,promocodeid);
        currentplancontroller.CurrentplanApi(context);
      });
    } catch (error) {
      print("Transaction declined: $error");
      if (paymentIntent.containsKey('id')) {
        print("Transaction ID: ${paymentIntent['id']}");
      }
    }
  }

  @override
  void initState() {
    Future.wait([
      getSubscriptionByid.GetSubscriptionApi(context, widget.subscriptionid),
      checkoutController.CheckoutApi(context, widget.state),
    ]).then((_) {
      totalamount((_) {});
    });
    print("sssssssssss$stripepaymentamount");
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
                padding: const EdgeInsets.only(top:5.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:20.0,top: 60.0),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor:newyellow,
                              child: Center(
                                child: IconButton(onPressed: (){Get.back();},icon: const Icon(Icons.arrow_back,color: Colors.white,),),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Padding(
                              padding: const EdgeInsets.only(left:40.0),
                              child: Image.asset("assets/logo/logowhite.png",height: displayheight(context)*0.15,color: newyellow, ),
                            )),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:45.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40),
                                topLeft: Radius.circular(40)
                            ),
                          ),
                          child:Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: checkoutController.checkoutdata.isEmpty?
                                const Center(child: CupertinoActivityIndicator(),)
                                :Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Checkout",style: billtittle,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              billingleft(),
                                              billingright()
                                            ],
                                          ),
                                ),
                                commondivider(const Color(0XFFD9D9D9)),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        child: Text("Discount",style: billsubtittle,),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        child: Row(
                                          children: [
                                            Text("\$ ",style: billsubsubtittle,),
                                            Text("${getpromocodeamount.toStringAsFixed(2)}",style: billsubsubtittle,),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                commondivider(const Color(0XFFD9D9D9)),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Promo code",style: billsubsubtittle,),
                                ),
                                promocode(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        child: Text("Grand Total",style: billsubtittle,),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        child: Row(
                                          children: [
                                            Text("\$ ",style: billsubsubtittle,),
                                            Text("${grandtotalamount?.toStringAsFixed(2)}",style: billsubsubtittle,),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:  const EdgeInsets.only(bottom:15.0,top: 15.0),
                                  child: SizedBox(
                                    height:displayheight(context)*0.06,
                                    child:_isLoading?const Center(child: CircularProgressIndicator(color: newyellow,)):ElevatedButton(
                                        style: ElevatedButton.styleFrom(backgroundColor: newyellow,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)
                                          )
                                        ),
                                        onPressed: ()=>setState(() async{
                                          if(grandtotalamount==0){
                                            squarePaymentController.SquarePaymentApi(context,"",newsubscriptionamount.toString(),finaltaxcalculated.toString(),
                                                newservicetax.toString(), newprocessingtax.toString(), newconvenicetax.toString(),
                                                promoamount.toString(),newfinalamount.toString(),widget.subscriptionid,"card",widget.plan,widget.month,promocodeid);
                                               // currentplancontroller.CurrentplanApi(context);

                                            // activatePlanController.ActivatePlanApi(context,widget.subscriptionid);
                                            // Get.to(Paymentsucessalert(subscriptionid: widget.subscriptionid,));
                                          }
                                          else{
                                             createpayment(context,stripepaymentamount);
                                              print(stripepaymentamount);
                                          }
                                        })
                                        , child: Center(child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Pay now",style: btntxtwhite,),
                                        ),)),
                                  ),
                                ),
                                SizedBox(height: displayheight(context)*0.10,)
                              ],
                            ),
                          )
                        ),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget billingleft(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text("Subscription Amount",style: billsubtittle,),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text("Tax",style: billsubtittle,),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text("Service Tax",style: billsubtittle,),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text("processing Tax",style: billsubtittle,),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text("convenience Tax",style: billsubtittle,),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text("Total Amount",style: billsubtittle,),
        )
      ],
    );
  }

  Widget billingright(){
    return Obx(() => Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding:  const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Text("\$ ",style: billsubsubtittle,),
              Text("${getSubscriptionByid.getsubscriptiondata[0]['subscriptionAmount']??''}",style: billsubsubtittle,),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child:Row(
            children: [
              Text("\$ ",style: billsubsubtittle,),
              Text("${finaltaxcalculated?.toStringAsFixed(2)}",style: billsubsubtittle,),

            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child:Row(
            children: [
              Text("\$ ",style: billsubsubtittle,),
              Text("${getSubscriptionByid.getsubscriptiondata[0]['serviceTax']??''}",style: billsubsubtittle,),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child:Row(
            children: [
              Text("\$ ",style: billsubsubtittle,),
              Text("${getSubscriptionByid.getsubscriptiondata[0]['processingTax']??''}",style: billsubsubtittle,),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child:Row(
            children: [
              Text("\$ ",style: billsubsubtittle,),
              Text("${getSubscriptionByid.getsubscriptiondata[0]['convenienceTax']??''}",style: billsubsubtittle,),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Text("\$ ",style: billsubsubtittle,),
              Text("$newfinalamount",style: billsubsubtittle,),
            ],
          ),
        )
      ],
    ));
  }

  Widget promocode(){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: displayheight(context) * 0.06,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0XFFD9D9D9)),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: displayheight(context) * 0.06,
              width: displaywidth(context) * 0.60,
              child: TextFormField(
                style: inputtxt,
                onChanged: (value) {
                  // promoCodeController.PromocodeApi(context, promocontroller.text);
                },
                cursorColor: Colors.black,
                controller: promocontroller,
                decoration: InputDecoration(
                  hintText: "Enter your code",
                  hintStyle: promotxt,
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                promoCodeController.PromocodeApi(context, promocontroller.text);
                bool promoFound = false;
                var promoData = promoCodeController.promocodedata[0];
                if (promoData['promocodeName'] == promocontroller.text) {
                  StackDialog.show("Promo Code", "Promo Code Applied Successfully", Icons.verified, Colors.green);
                  setState(() {
                    promoamount = promoData['discount'].toDouble();
                    double discountAmount = (newfinalamount != null ? newfinalamount!.toDouble() : 0) * (promoamount / 100);
                    getpromocodeamount = discountAmount;
                    grandtotalamount = newfinalamount != null ? (newfinalamount!.toDouble() - discountAmount) : 0;
                    totalamount((double finalAmount) {
                      grandtotalamount = finalAmount;
                    });
                    promocodeid = "${promoCodeController.promocodedata[0]['id']}";
                    print('Discount Amount: $discountAmount');
                    print('Grand Total Amount: $grandtotalamount');
                  });
                  promoFound = true;
                  promocontroller.clear();
                }
                if (!promoFound) {
                  // StackDialog.show("Promo Code", "Promo Code Not Found", Icons.info, Colors.red);
                  promocontroller.clear();
                }
              },
              child: Container(
                height: displayheight(context) * 0.06,
                width: displaywidth(context) * 0.30,
                decoration: BoxDecoration(
                  color: newyellow,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text("Apply", style: btntxtwhite),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


