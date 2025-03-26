import 'package:bookstash/Pages/flutterToast.dart';
import 'package:bookstash/service/authService.dart';
import 'package:flutter/material.dart';

class signUpScreen extends StatefulWidget {
  const signUpScreen({super.key});

  @override
  State<signUpScreen> createState() => _signUpScreenState();
}

class _signUpScreenState extends State<signUpScreen> {

TextEditingController emailController=TextEditingController();
TextEditingController passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: Center(
  child: Padding(padding: EdgeInsets.all(10),
  child: Column(
mainAxisAlignment: MainAxisAlignment.center,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Align(
  alignment: Alignment.center,
  child: Text("SIGN UP",style: TextStyle( fontWeight: FontWeight.w800,fontSize: 30),)),
SizedBox(height: 20,),
TextFormField(
 controller: emailController,
 decoration: InputDecoration(
  border: OutlineInputBorder(),
  label: Text("Email"),
  hintText: "Enter your email"
 ),

),
SizedBox(height: 10,),

TextFormField(
 controller: passwordController,
 decoration: InputDecoration(
  border: OutlineInputBorder(),
  label: Text("Password"),
  hintText: "Enter your password"
 ),

),
SizedBox(height: 10,),
SizedBox(width: double.infinity,
height: 45,
child: OutlinedButton(
  onPressed: ()async{
await AuthserviceHelper.createAccountwithemail(emailController.text, passwordController.text).then((value){
if(value=="Account create successfully"){

  Message.Show(message: "Account create successfully");
  Navigator.pushNamedAndRemoveUntil(context,"/home" , (route)=>false);
}else{
  Message.Show(message: "Error:$value");
}

});

  }, 
child: Text("Sign Up")),
),
SizedBox(height: 10,),
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text("already have  an account?"),
    TextButton(
      onPressed: (){
Navigator.pop(context);
      }, 
      child: Text("Login"))
  ],
),
],
  ),
  ),

  
),
    );
  }
}