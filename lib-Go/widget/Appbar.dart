import 'package:connect_athelete/Common/Common%20Textstyle.dart';
import 'package:connect_athelete/widget/Arrow%20icon.dart';
import 'package:flutter/material.dart';

AppBar appbarwidget(String?text){
  return AppBar(
    backgroundColor:  Color(0xFFF1F1F1),
    // backgroundColor: Colors.white,
    // elevation: 1,
    shadowColor: Colors.grey,
    surfaceTintColor: Colors.transparent,
    leading: arrowback(),
    centerTitle: true,
    title: Text(text!,textAlign: TextAlign.center,style: chatheadingtxtnew,),
  );
}