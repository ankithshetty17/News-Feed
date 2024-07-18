import 'package:flutter/material.dart';

void ShowSnackBar(BuildContext context,String Messsage){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Container(
  child: Text(Messsage,style:const  TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
  textAlign: TextAlign.center,),
    ),
    backgroundColor: Colors.blue,
    elevation: 10,
    margin:const  EdgeInsets.all(50),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      
    ),
    duration:const  Duration(seconds: 3),
    )
  );
}