import 'dart:convert';
import 'package:connect_athelete/Config.dart';
import 'package:connect_athelete/Screens/Payment/Paymentsucessalert.dart';
import 'package:connect_athelete/Screens/Subscription/ActivatePlanController.dart';
import 'package:connect_athelete/widget/Snackbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SquarePaymentController extends GetConnect{

  String ?service;
  RxList<dynamic>paymentdata=[].obs;
  String ?gettoken;
  String?sportid;
  int?userid;

  Future<dynamic> SquarePaymentApi(BuildContext context,String nonce,subscriptionamount,tax,servicetax,processingtax,conveniencetax,promodiscount,grandtotal,subscriptionid,modeofpayment,plan,month,promocodeid)async{
    final SharedPreferences shref=await SharedPreferences.getInstance();
    var token=shref.getString('token');
    gettoken=token??'';
    
    var id=shref.getString("sportid");
    sportid=id??'';

    var getuserid=shref.getInt('userid');
    userid=getuserid??0;

    service=ApiConfig.service;

    final baseurl="${service}/api/v1/paysubscription";

    final url=Uri.parse(baseurl);

    final header={
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Authorization':'$gettoken'
    };

    final json='{"convenienceTax": "$conveniencetax","discount":"$promodiscount","modeOfPayment": "$modeofpayment","paymentStatus": "Succeeded","paymentTransactionId": "$nonce","processingTax": "$processingtax","promocodeId": "$promocodeid","serviceTax":"$servicetax","subscriptionId": "$subscriptionid","subscriptionMonth": "$month","subscriptionName": "$plan","subtotalAmount": "$subscriptionamount","taxAmount": "$tax","taxPercentage": "$tax","totalAmount": "$grandtotal","userId": "$userid"}';
    final response=await http.post(url,headers: header,body: json.toString());

    final data=jsonDecode(response.body);

    if(response.statusCode==201){
      print(data);
      Get.to( Paymentsucessalert(subscriptionid:subscriptionid,));
      final value=(data['data']);
      paymentdata.assignAll(value);
      print(value);
      return response;
    }
    else if(response.statusCode==500){
      StackDialog.show("Server Error", "Internal Server Error", Icons.info, Colors.red);
    }
    else{
      print(data);
      print("paymennt failed");
      return response;
    }
  }
}