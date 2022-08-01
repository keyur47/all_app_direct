import 'package:flutter/material.dart';

Widget boxNext({required  GestureTapCallback onTap}){
  return GestureDetector(
    onTap: onTap,
    child: Container(
      child:Icon(Icons.arrow_forward_ios_outlined) ,
    ),
  );
}