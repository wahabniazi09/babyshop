import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drawer/consts/consts.dart';
import 'package:flutter/material.dart';

Widget dashboardButton(context,{title,count,icon}) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.3,
    height: 80,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
    color: Colors.deepPurple[900],
      borderRadius: BorderRadius.circular(10)
    ),
    child: Row(
      children: [
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('$title',style: const TextStyle(
                  fontFamily: bold,
                  fontSize: 16.0,
                  color: whiteColor
                ),),
                Text('$count',style: const TextStyle(
                  fontFamily: bold,
                  fontSize: 20.0,
                  color: whiteColor
                ),),
          ],
        )),
        Image.asset(icon,width: 40,color: whiteColor,)
      ],
    ),
  );
}
