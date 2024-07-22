import 'package:connect_athelete/Common/Common%20Color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget backbutton(){
  return  Padding(
    padding: const EdgeInsets.only(left:15.0),
    child: CircleAvatar(
      radius: 20,
      backgroundColor:newyellow,
      child: Center(
        child: IconButton(onPressed: (){Get.back();},icon: const Icon(Icons.arrow_back_ios_new,color: Colors.white,),),
      ),
    ),
  );
}