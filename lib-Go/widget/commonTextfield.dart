import 'package:connect_athelete/Common/Common%20Color.dart';
import 'package:connect_athelete/Common/Common%20Size.dart';
import 'package:connect_athelete/Common/Common%20Textstyle.dart';
import 'package:flutter/material.dart';

Widget commontextfield(String text,controller,type) {
  return Builder(builder: (BuildContext context) {
    return Container(
      height: displayheight(context) *0.07,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextFormField(
          keyboardType: type,
          style: inputtxt,
          controller: controller!,
          cursorColor: greytxtcolor,
          decoration: InputDecoration(
            hintText: text,
            hintStyle: textfieldhint,
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
                borderRadius: BorderRadius.circular(10)
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
                borderRadius: BorderRadius.circular(10)
            ),
          ),
        ),
      ),
    );
  });
}