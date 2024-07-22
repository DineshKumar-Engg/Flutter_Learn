import 'package:connect_athlete_admin/Common/Common%20Color.dart';
import 'package:connect_athlete_admin/Common/Common_size.dart';
import 'package:connect_athlete_admin/Common/Common_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

Widget elevation_button(String val,routescreen){
  return Builder(
      builder:(context){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          height: displayheight(context)*0.06,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: secondary,shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            )),
            child: Text(val,style: btntxtwhite,),
            onPressed: (){
              Navigator.push(context, PageTransition(
                  child: routescreen,
                  type: PageTransitionType.fade,
                 ctx: context,
                    inheritTheme: true
              ));
            },
          ),
        ),
      );
  });
}