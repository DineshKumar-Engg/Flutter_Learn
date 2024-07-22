import 'package:flutter/material.dart';
import 'Common Color.dart';
import 'Common Size.dart';

Widget commonbackground(BuildContext context) {
  return Container(
    height: displayheight(context)*1,
    width: double.infinity,
    color: primary,
    child: Column(
      children: [
        // SizedBox(
        //   height: displayheight(context)*0.30,
        //   width: double.infinity,
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/img.png",width: displaywidth(context)*0.30,color: Colors.white,),
            Image.asset("assets/img_1.png",height: displayheight(context)*0.30,)
          ],
        ),
        SizedBox(
          height:displayheight(context)*0.05,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Image.asset("assets/img_2.png",width: displaywidth(context)*0.25,)),

        Align(
            alignment: Alignment.centerRight,
            child: Image.asset("assets/img_3.png",width: displaywidth(context)*0.25,)),
      ],
    ),
  ) ;
}