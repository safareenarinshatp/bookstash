import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
//for receiving values from firebase
  Map payloadContent ={};
  @override
  Widget build(BuildContext context) {

    final data=ModalRoute.of(context)!.settings.arguments;
//background terminated state
    if(data is RemoteMessage){
payloadContent=data.data;

    }

    //foreground state
    if(data is NotificationResponse){

      payloadContent=jsonDecode(data.payload!);
    }

    String firstKey=payloadContent.keys.first;
    return Scaffold(
appBar: AppBar(title: Text("Message"),),
body: Center(
  child: Padding(padding: EdgeInsets.all(10),
  child: Column(
children: [

  SizedBox(height: 10,),
  SizedBox(
    width: double.infinity,
    height: 100,
    child:Card(
color: Colors.lightBlueAccent,
elevation: 10,
child: Padding(padding: EdgeInsets.all(10),
child: Text("Book name:$firstKey",style: TextStyle(fontSize: 20,color: Colors.white),),
),

    ) ,
  ),
  SizedBox(height: 10,),
  SizedBox(
    width: double.infinity,
    height: 100,
    child:Card(
color: Colors.lightBlueAccent,
elevation: 10,
child: Padding(padding: EdgeInsets.all(10),
child: Text("Price:${payloadContent[firstKey]}",style: TextStyle(fontSize: 20,color: Colors.white),),
),

    ) ,
  )


],


  ),
  ),
),

    );
  }
}