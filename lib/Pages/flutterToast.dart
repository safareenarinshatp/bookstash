import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Message{

  static void Show({
String message='Done!',

ToastGravity Gravity=ToastGravity.BOTTOM,
int timeInSecForIosWeb=2,
Color backgroundColor= Colors.cyanAccent,
Color textColor=Colors.white,
double fontSize=15.5,
  })

  {

    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: Gravity,
        timeInSecForIosWeb: timeInSecForIosWeb,
        backgroundColor:backgroundColor,
        textColor: textColor,
        fontSize:fontSize
    );
  }
}