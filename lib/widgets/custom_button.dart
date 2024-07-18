import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const CustomButton({super.key,required this.text,required this.onPressed});
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed,
    child:Text(text,
             style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),

     style: ElevatedButton.styleFrom(
      primary:const  Color.fromARGB(255,12, 84, 190),
      elevation: 0,
      minimumSize: const Size(231, 49),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        
      )
     ), 
     );
  }
}