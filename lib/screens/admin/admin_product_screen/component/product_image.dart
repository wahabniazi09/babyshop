import 'package:drawer/consts/consts.dart';
import 'package:flutter/material.dart';

Widget productImage({label,onpress}) {
  return Container(
    width: 100,
    height: 100,
    decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: BorderRadius.circular(20)
    ),
    child: Center(child: Text('$label',style: TextStyle(color: darkFontGrey,fontSize: 16.0,fontFamily: bold),)),
  );
}
