import 'package:firebase_auth/firebase_auth.dart';

class AuthserviceHelper {
  static Future<String> createAccountwithemail(
      String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return "Account create successfully";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }
// login
  static Future<String >loginwithEmail(String email,String password) async{
try {

 await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password) ;


return "Login Successfull";


} on FirebaseAuthException catch(e){
return e.message.toString();
  
}
catch(e){

  return e.toString();
}
  

  }

//logout

static Future logout()async{
try{

await FirebaseAuth.instance.signOut();


}on FirebaseAuthException catch(e){

  return e.message.toString();
}

}

//check login or not
static Future<bool> isUserLoggedin()async{

  var currentUser=FirebaseAuth.instance.currentUser;
  return currentUser!=null?true:false;
}


}