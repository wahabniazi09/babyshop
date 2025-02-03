import 'package:drawer/consts/colors.dart';
import 'package:flutter/material.dart';

Widget AdminCustomTextField({String? label, String? hint, controller,ispass}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label!,
        style: const TextStyle(
          color: whiteColor,
          fontSize: 14,
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      TextFormField(
        obscureText: ispass ,
          controller: controller,
          decoration: InputDecoration(
              hintStyle:  TextStyle(
                color: whiteColor,
                fontSize: 14
              ),
              // prefixIcon: const Icon(Icons.email),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),  
              hintText: hint,
              isDense: true,
              // filled: true,
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.redAccent)))),
      SizedBox(
        height: 10,
      )
    ],
  );
}
