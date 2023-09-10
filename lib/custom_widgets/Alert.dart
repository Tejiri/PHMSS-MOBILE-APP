import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

bottomAlert(
    {required BuildContext context,
    String? title,
    String? message,
    required bool isError}) {
  return Flushbar(
    icon: Icon(
      Icons.info,
      color: Colors.white,
    ),
    backgroundColor: isError ? Colors.red : Colors.green,
    // maxWidth: ,
    borderRadius: BorderRadius.circular(10),
    margin: EdgeInsets.all(20),
    title: title,
    message: message,
    duration: Duration(seconds: 2),
  )..show(context);
}