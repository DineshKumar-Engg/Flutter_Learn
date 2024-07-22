import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../Common/Common Color.dart';
import '../Common/Common Size.dart';
import '../Common/Common Textstyle.dart';

Widget decorationcontainer(IconData icon,String txt,routescreen){
  return Builder(builder: (context){
    return InkWell(
      onTap: (){
        Navigator.push(context,
            PageTransition(
                ctx: context,
                inheritTheme: true,
                child: routescreen,
                type:PageTransitionType.fade,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          height: displayheight(context)*0.08,
          width: displaywidth(context)*0.17,
          decoration: BoxDecoration(
              color: Color(0xFFF3F2F9),
              borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon,color: primary,size: 30,),
              Text(txt,style:desinatetxt ,)
            ],
          ),
        ),
      ),
    );
  });
}