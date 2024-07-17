import 'package:flutter/material.dart';
import 'package:newsfeed/themes/colors.dart';
import 'package:newsfeed/widgets/custom_button.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodybg,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:const  Text('MyNews',
                     style: TextStyle(color: Color.fromARGB(255,12, 84, 190),
                    fontWeight: FontWeight.bold),
                    ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(padding:const  EdgeInsets.all(12),
      child:
      Column(
        children: [
       const    Expanded(
            child: 
          Center(child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Name',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(15))
              )
            ),
          ),
        SizedBox(height: 10,),
           TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'E-mail',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(15))
              )
            ),
          ),
            
           SizedBox(height: 10,),
           TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Password',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(15))
              )
            ),
          ),
            ],
          )
          ),
          ),
            
            const  CustomButton(text: 'Signup'),
            const   SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Alredy have an account?'),
                  GestureDetector(
                    onTap:(){
                    Navigator.pushNamed(context, '/login');
                    },
                    child:
                const   Text('Login',
                  style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),
                  ),
                  ),

                ],
              )
        ],
      ),
      ),
    );
  }
}