import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  const CustomButton({super.key,required this.text});
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){},
    child:Text(text,
             style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),

     style: ElevatedButton.styleFrom(
      primary: Color.fromARGB(255,12, 84, 190),
      elevation: 0,
      minimumSize: Size(231, 49),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        
      )
     ), 
     );
  }
}