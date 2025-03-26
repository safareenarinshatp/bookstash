import 'dart:convert';

import 'package:bookstash/Auth/Ui/loginScreen.dart';
import 'package:bookstash/Auth/Ui/signUpScreen.dart';
import 'package:bookstash/Pages/homePage.dart';
import 'package:bookstash/Pages/messageScreen.dart';
import 'package:bookstash/firebase_options.dart';
import 'package:bookstash/service/authService.dart';
import 'package:bookstash/service/notificationService.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

final navigatorKey=GlobalKey<NavigatorState>();


Future _firebaseBackgroundMessage(RemoteMessage message)async{

  if(message.notification!=null){
    print("A notification found in background");
  }
}


void main() async{
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//initialize firebase messaging
await PushNotificationHelper.init();


//initialize local notification
await PushNotificationHelper.localNotificationInitiolization();


FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message){

 if (message.notification!=null) {
  print("Background notification tapped");
  navigatorKey.currentState!.pushNamed("/message",arguments: message);

 }

});
//foreground 
FirebaseMessaging.onMessage.listen((RemoteMessage message){
String payloadContent=jsonEncode(message.data);
print("message found in background");
if(message.notification!=null){
  PushNotificationHelper.showLocalNotification(
    title: message.notification!.title!, 
    body: message.notification!.body!,
     payload: payloadContent);
}

});

runApp(myApp());
}
class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
navigatorKey: navigatorKey,


       // home:  homeScreen() ,
      routes: {
      "/":(context)=>checkUser(),
      "/login":(context)=>Loginscreen(),
      "/home":(context)=>homeScreen(),
      "/signup":(context)=>signUpScreen(),
      "/message":(context)=>MessageScreen()
      }, 
    );
  }
}
class checkUser extends StatefulWidget {
  const checkUser({super.key});

  @override
  State<checkUser> createState() => _checkUserState();
}

class _checkUserState extends State<checkUser> {

  @override
  void initState() {
    AuthserviceHelper.isUserLoggedin().then((value){
if(value){

  Navigator.pushReplacementNamed(context, "/home");
}else{

  Navigator.pushReplacementNamed(context, "/login");
}

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}