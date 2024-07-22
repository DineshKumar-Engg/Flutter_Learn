import 'package:flutter/material.dart';

Widget commonfilledtxt(Text text,controller){
  return TextFormField(
    decoration: InputDecoration(
      fillColor:const Color(0xFFFAFAFA),
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color:Color(0xFF6F7F95),
          width: 1.05
        )
      ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color:Color(0xFF6F7F95),
                width: 1.05
            )
        )
    ),
  );
}