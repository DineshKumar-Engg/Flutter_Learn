import 'package:connect_athelete/Common/Common%20Color.dart';
import 'package:connect_athelete/Common/Common%20Textstyle.dart';
import 'package:flutter/material.dart';

Widget newtextfield(controller,type){
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: SizedBox(
      height: 55,
      width: double.infinity,
      child: TextFormField(
        keyboardType: type,
        style: inputtxt,
        controller: controller,
        cursorColor: primary,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(0.10000000149011612),width: 1),
            borderRadius: BorderRadius.circular(5)
          ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withOpacity(0.10000000149011612),width: 1),
                borderRadius: BorderRadius.circular(5)
            )
        ),
      ),
    ),
  );
}