import 'package:bookstash/Pages/books.dart';
import 'package:bookstash/Pages/flutterToast.dart';
import 'package:bookstash/service/authService.dart';
import 'package:bookstash/service/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {

Stream? bookStream;

TextEditingController titleController =TextEditingController();
TextEditingController priceController =TextEditingController();

TextEditingController autherController =TextEditingController();


dynamic getInfoInit()async{
bookStream =await  DatabaseHelper().getAllBookInfo();
setState(() {
  
});

}
@override
 void initState(){
  getInfoInit();
super.initState();
}

Widget allBookInfo(){
  return StreamBuilder( builder: (context,AsyncSnapshot snapshot){
   return  snapshot.hasData?ListView.builder(
    itemBuilder:(context,index){
      DocumentSnapshot documentSnapshot= snapshot.data.docs[index];
      return Container(
        margin: EdgeInsets.only(bottom: 22),
        child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color:Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(
          
      
          children: [
            Icon(Icons.book, size:40,color: Colors.white,),
            SizedBox( width:  1100,),
            InkWell(
              child: 
              Icon(Icons.edit, size:40,color: Colors.white,),
              onTap: (){
                titleController.text=documentSnapshot["Title"];
                priceController.text=documentSnapshot["price"];
                autherController.text=documentSnapshot["Author"];
                  editBook(documentSnapshot["Id"]);

              },
              ),
              SizedBox( width:  10,),
              InkWell(
                onTap: (){
                 showDeleteConfirmation(context, documentSnapshot["Id"]);
                 
                },
                child: Icon(Icons.delete,size:40,color: Colors.white,))
          ],
        ),
        SizedBox(height: 10,),
          Text('Title: ${documentSnapshot["Title"]}' ,style: TextStyle( fontWeight: FontWeight.w800,color:Colors.white,fontSize: 20), ),
            Text('Price: ${documentSnapshot["price"]}' ,style: TextStyle( fontWeight: FontWeight.w800,color:Colors.white,fontSize: 20)),
        Text('Author: ${documentSnapshot["Author"]}' ,style: TextStyle( fontWeight: FontWeight.w800,color:Colors.white,fontSize: 20))
        ],
        
          ),
        ),
        
        ),
      );

    } ,
   itemCount:snapshot.data.docs.length ,
   ): Container();


  },
  stream: bookStream,
  );
}
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        
appBar: AppBar(title: Text('BOOKSTASH'),
actions: [IconButton(onPressed: () {
  showLogoutConfirmation(context);
},
icon: Icon(Icons.logout_sharp))

],
),
body: Container(
  margin: EdgeInsets.all(10),
    child: Column(
        children: [
Expanded(child: allBookInfo()),
        ],
    ),
),
floatingActionButton: FloatingActionButton(
onPressed: (){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Books()));
},
tooltip:'add',
child:  Icon(Icons.add),
    )
    );
  }

  Future editBook(String Id){
return showDialog(
  context: context,
 builder: (context)=>AlertDialog(

content: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
children: [
  Align(
    alignment: Alignment.center,
    child: Text('Edit Book',style: TextStyle( color: Theme.of(context).primaryColor,  fontSize: 30,fontWeight: FontWeight.bold)
    ),
  ),
  SizedBox(height: 15,),
  Divider( height: 10,thickness: 5,  color:Theme.of(context).primaryColor,),
 SizedBox(height: 15,),
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
Row(
children: [
  OutlinedButton(
    onPressed: () async{
Map<String,dynamic>updateBookDetails={
"Title":titleController.text,
"price":priceController.text,
"Author":autherController.text,
"Id":Id

};
await DatabaseHelper().updateBook(Id, updateBookDetails).then((value){
Message.Show(message: 'Book updated successfully');
Navigator.pop(context);
}
);
    },
     child: Text('Update')),
     SizedBox(width: 30,),
     OutlinedButton(
    onPressed: (){
      Navigator.pop(context);
    },
     child: Text('Cancel'))
],

)
],

),
 ));

  }

 void showDeleteConfirmation(BuildContext context,String Id){
showDialog(context: context,
 builder: (BuildContext context){

  return AlertDialog(
title: Text("Confirm Detetion"),
content: Text("Are you sure you want to delete ths book?"),
actions: [

  TextButton(onPressed: ()async{
await   DatabaseHelper().deleteBook(Id).then((value){
Message.Show(message: 'Book deleted successfully');
Navigator.pop(context);

  });
  },
    child: Text('Yes')),



   

  TextButton(onPressed: (){

    Navigator.of(context).pop(false);
  }, 
  child: Text('No')),
],
  );
 }
);

 } 





 void showLogoutConfirmation(BuildContext context){
showDialog(context: context,
 builder: (BuildContext context){

  return AlertDialog(
title: Text("Confirm Logout"),
content: Text("Are you sure you want to logout this account?"),
actions: [

  TextButton(onPressed: ()async{
await  AuthserviceHelper.logout();
Navigator.pushReplacementNamed(context, "/login");
  
},

  child: Text('Yes')),
  TextButton(onPressed: (){

    Navigator.of(context).pop(false);
  }, 
  child: Text('No')),
],
  );
 }
);

  }

}