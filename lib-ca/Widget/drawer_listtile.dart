import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../Common/Common_textstyle.dart';

Widget drawer_listtile(routescreen,IconData icon,String txt){
  return Builder(builder: (context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:10.0,vertical: 4.0),
      child: ListTile(
        onTap: (){
          Navigator.push(context, PageTransition(
              child: routescreen,
              type: PageTransitionType.fade,
          ctx: context,
            inheritTheme: true
          ));
        },
        leading: Icon(icon,color: const Color(0XFF515151),),
        title:Text(txt,style: drawertxttitle,),
        // trailing: Icon(Icons.arrow_forward_ios_rounded,color: Color(0XFF515151),),

      ),
    );
  });
}