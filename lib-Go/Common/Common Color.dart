import 'package:flutter/material.dart';

  // const primary=Color(0XFF000080);
  const secondary=Color(0XFFFFD700);
  // const newyellow=Color(0xFFECAC1A);
  const circlecolor=Color(0XFF1919AF);
  const greyhint=Color(0XFFD9D9D9);
 const greytxtcolor=Color(0XFF34363E);
 // Color background=const Color(0XFFE9E9FF);
  Color newgrey=Colors.black.withOpacity(0.05000000074505806);

///new color code ////
   const primary=Color(0xff2a2e70);
   const newyellow=Color(0xfff08424);
   const background= Color(0XFFFAFAFC);



Gradient bluegradient=LinearGradient(
  begin:Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.blue,
      Colors.blue.shade500,
      Colors.blue.shade300
    ]);
Gradient purplegradient=LinearGradient(
    begin:Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.purpleAccent,
      Colors.purpleAccent.shade100,
    ]);
Gradient redgradient=LinearGradient(
    begin:Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.redAccent,
      Colors.redAccent.shade100
    ]);
Gradient orandegradient=const LinearGradient(
    begin:Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.orange,
      Colors.orangeAccent
    ]);
Gradient primarygradient=const LinearGradient(
    begin:Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      primary,
      primary
    ]);
BoxDecoration commonshadow=BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(30),
  boxShadow: const [
    BoxShadow(
      color: Color.fromRGBO(215, 215, 215, 0.83),
      offset: Offset(2,6),
      blurRadius: 30,
      spreadRadius: 1,
    )
  ]
);

BoxDecoration commonshadow20=BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: const [
      BoxShadow(
        color: Color.fromRGBO(215, 215, 215, 0.83),
        offset: Offset(2,6),
        blurRadius: 30,
        spreadRadius: 1,
      )
    ]
);

BoxDecoration commonshadowprofile=const BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(10),
      bottomRight: Radius.circular(10)
    ),
    boxShadow: [
      BoxShadow(
        color: Color.fromRGBO(215, 215, 215, 0.83),
        offset: Offset(2,6),
        blurRadius: 30,
        spreadRadius: 1,
      )
    ]
);