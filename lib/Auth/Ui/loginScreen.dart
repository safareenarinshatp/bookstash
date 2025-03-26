import 'package:bookstash/Pages/flutterToast.dart';
import 'package:bookstash/service/authService.dart';
import 'package:flutter/material.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {

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
  child: Text("LOGIN",style: TextStyle( fontWeight: FontWeight.w800,fontSize: 30),)),
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
  onPressed: () async{
await AuthserviceHelper.loginwithEmail(emailController.text, passwordController.text).then((value){
if(value=="Login Successfull"){

  Message.Show(message: "Login Successfully!!");
  Navigator.pushReplacementNamed(context, "/home");

}else{

  Message.Show(message: "Error:$value");

}

});

  }, 
child: Text("Login")),
),
SizedBox(height: 10,),
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text("create an account!"),
    TextButton(
      onPressed: (){
Navigator.pushNamed(context, "/signup");
      }, 
      child: Text("Register here"))
  ],
),
],
  ),
  ),

  
),
    );
  }
}