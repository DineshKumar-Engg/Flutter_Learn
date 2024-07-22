import 'package:flutter/material.dart';

Widget commoncontainer(height,Widget widget){
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      height:height,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40)
        ),
      ),
      child:widget,
    ),
  );
}