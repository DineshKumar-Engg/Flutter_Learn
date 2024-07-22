import 'dart:io';
import 'package:connect_athelete/Common/Common%20Color.dart';
import 'package:connect_athelete/Common/Common%20Size.dart';
import 'package:connect_athelete/widget/Appbar.dart';
import 'package:flutter/material.dart';

class ViewImagescreen extends StatefulWidget {
   final String image;
   ViewImagescreen({super.key,required this.image});

  @override
  State<ViewImagescreen> createState() => _ViewImagescreenState();
}

class _ViewImagescreenState extends State<ViewImagescreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: background,
        appBar:appbarwidget("Images"),
      body: Center(
        child: SizedBox(
          // height: displayheight(context)*0.50,
          width: double.infinity,
          child:Image.network("${widget.image}",fit: BoxFit.fitWidth) ,
        ),
      ),
      
    );
  }
}
