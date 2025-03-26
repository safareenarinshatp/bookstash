import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseHelper{
// add book 
Future addBookDetails(Map<String,dynamic> bookInfoMap,String id) async{

  return await FirebaseFirestore.instance.collection("Books").doc(id).set(bookInfoMap);
}
// get book info
Future<Stream<QuerySnapshot>>getAllBookInfo() async{
  return await FirebaseFirestore.instance.collection("Books").snapshots();
}

//update book

Future updateBook(String Id,Map<String,dynamic>updateBookDetails) async{

 return await FirebaseFirestore.instance.collection("Books") .doc(Id).update(updateBookDetails);
}

//delete nbook

Future deleteBook(String Id) async{

return FirebaseFirestore.instance.collection("Books").doc(Id).delete();
}

}