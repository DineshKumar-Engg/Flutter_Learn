import 'package:connect_athelete/Common/Common%20Color.dart';
import 'package:connect_athelete/Common/Common%20Textstyle.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

Widget drawerlisttile(IconData icon,String text,routescreen){
  return Builder(builder: (context){
    return ListTile(
      onTap: (){
        Navigator.push(context, PageTransition(
            ctx: context,
            inheritTheme: true,
            child: routescreen,
            type: PageTransitionType.fade));
      },
      leading: Icon(icon,color: primary,),
      title:Text(text,style: drawertxt,),
      trailing: const Icon(Icons.arrow_forward_ios_rounded,color: primary,),
    );
  });
}

