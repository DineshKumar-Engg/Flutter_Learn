import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Padding shimmer(double height){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Shimmer.fromColors(
        baseColor:  Colors.white,
        highlightColor: Colors.grey.withOpacity(0.7),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            height: height,
            width: double.infinity,
            decoration:   BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.1,1.0),
                  blurRadius: 6.0
                ),
              ],
              borderRadius: BorderRadius.circular(10)
            ),
          ),
        )),
  );
}