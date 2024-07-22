import 'package:connect_athelete/Common/Common%20Size.dart';
import 'package:connect_athelete/Common/Common%20Textstyle.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../Common/Common Color.dart';

Builder primarybuttons(String val,routescreen){
  return Builder(builder: (context){
    return SizedBox(
      height: displayheight(context)*0.06,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: newyellow,shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        )),
          onPressed: (){
            Navigator.push(context, PageTransition(
              ctx:context,
              child: routescreen,
              type: PageTransitionType.fade,
              inheritTheme: true
            ));
          }, child: Text(val,style: btntxtwhite,)),
    );
  });
}