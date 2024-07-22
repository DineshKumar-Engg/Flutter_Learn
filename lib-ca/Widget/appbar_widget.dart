import 'package:connect_athlete_admin/Common/Common_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar appbar_widget(String txt){
  return AppBar(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    shadowColor: Colors.grey,
    elevation: 0.5,
    leading: IconButton(onPressed: (){
      Get.back();
    }, icon: Icon(Icons.arrow_back_ios_new,color: Colors.black,)),
     title: Text(txt,style: appbartxt,),
    centerTitle: true,
  );
}