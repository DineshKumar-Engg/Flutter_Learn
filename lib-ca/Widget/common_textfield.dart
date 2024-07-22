import 'package:connect_athlete_admin/Common/Common_size.dart';
import 'package:flutter/material.dart';

import '../Common/Common Color.dart';
import '../Common/Common_textstyle.dart';

Widget common_textfield(controller,String txt,keyboardtype){
  return  Padding(
    padding: const EdgeInsets.all(8.0),
    child: Builder(
      builder: (context) {
        return SizedBox(
          height: displayheight(context)*0.07,
          child: TextFormField(
            style: inputtxt,
            cursorColor: Colors.black,
            controller: controller,
            keyboardType: keyboardtype,
            decoration:  InputDecoration(
                hintText:txt,
                hintStyle:loginhinttxt ,
                enabledBorder:  OutlineInputBorder(
                    borderSide: const BorderSide(color: textfieldcolor),
                    borderRadius: BorderRadius.circular(10.0)
                ),
                focusedBorder:  OutlineInputBorder(
                    borderSide: BorderSide(color: textfieldcolor),
                    borderRadius: BorderRadius.circular(10.0)
                )
            ),
          ),
        );
      }
    ),
  );
}