import 'package:bookstash/Pages/flutterToast.dart';
import 'package:bookstash/service/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

class Books extends StatefulWidget {
  const Books({super.key});

  @override
  State<Books> createState() => _BooksState();
}

class _BooksState extends State<Books> {
TextEditingController titleController =TextEditingController();
TextEditingController priceController =TextEditingController();

TextEditingController autherController =TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(title: Text('Add a book'),),
body: Container(
  margin: EdgeInsets.only(left: 20,right: 20,top: 30),
child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
children: [

  Text('Title'),
  Container(
    padding: EdgeInsets.all(5),
    decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(20)),
child: TextField(
controller: titleController,
decoration: InputDecoration(border: InputBorder.none)

),
  ),
Text('Price'),
  Container(
     padding: EdgeInsets.all(5),
    decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(20)),
child: TextField(
controller: priceController,
decoration: InputDecoration(border: InputBorder.none)

),



  ),
  Text('Auther'),
  Container(
     padding: EdgeInsets.all(5),
    decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(20)),
child: TextField(
controller: autherController,
decoration: InputDecoration(border: InputBorder.none)

),



  ),

SizedBox(height: 20,),
Center(
child: OutlinedButton(
  onPressed: () async{

String Id=randomAlphaNumeric(10);
Map<String,dynamic>bookInfoMap={

  "Title":titleController.text,
  "price":priceController.text,
  "Author":autherController.text,
  "Id":Id
};
 await DatabaseHelper().addBookDetails(bookInfoMap, Id).then((value){
// Fluttertoast.showToast(
//         msg: "Book added successfully!!",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: const Color.fromARGB(255, 156, 130, 147),
//         textColor: Colors.white,
//         fontSize: 16.0
//     );
Message.Show();
Navigator.of(context).pop();

 });
  },
   child: Text('ADD')),
),

  
],

),
 

),
    );
  }
}