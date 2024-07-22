import 'package:connect_athelete/Common/Common%20Color.dart';
import 'package:connect_athelete/Common/Common%20Size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Common/Common Textstyle.dart';

class Viewchatprofilescreen extends StatefulWidget {
  String?image,name;
   Viewchatprofilescreen({super.key,required this.image,required this.name});

  @override
  State<Viewchatprofilescreen> createState() => _ViewchatprofilescreenState();
}

class _ViewchatprofilescreenState extends State<Viewchatprofilescreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1F1F1),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Center(child: Image.network("${widget.image}"),),
           Positioned(
            left:0 ,
            right: 0,
            bottom:200 ,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right:150.0),
                  child: Text("${widget.name??''}",style: requesttxtbold,),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
