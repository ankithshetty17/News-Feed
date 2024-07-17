import 'package:flutter/material.dart';
import 'package:newsfeed/themes/colors.dart';
import 'package:newsfeed/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   final _fromKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isObscured = true;

  void _toggleVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

 String? _validateEmail(String? email) {
  if (email == null || email.isEmpty) {
    return 'Email cannot be empty';
  }
  final RegExp regex = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    caseSensitive: false,
    multiLine: false,
  );
  if (!regex.hasMatch(email)) {
    return 'Enter a valid email address';
  }
  return null;
}
  @override
  Widget build(BuildContext context) {
     return  Scaffold(
      backgroundColor: bodybg,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:const  Text('MyNews',
                     style: TextStyle(color:  Color.fromARGB(255,12, 84, 190),
                    fontWeight: FontWeight.bold),
                    ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(padding:const  EdgeInsets.all(12),
      child:
      Column(
        children: [
          Expanded(
            child: 
          Center(
            child:Form(
            key: _fromKey,
            child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
         SizedBox(height: 10,),
           TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'E-mail',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(15))
              ),
               border: OutlineInputBorder(
                 borderRadius: BorderRadius.all(Radius.circular(15))
               ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(15))
              )
             
            ),
            keyboardType:TextInputType.emailAddress,
            validator: _validateEmail,
            
          ),
            
           SizedBox(height: 10,),
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
              border: OutlineInputBorder(
                 borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(15))
              ),
                suffixIcon: IconButton(
            icon: Icon(_isObscured ? Icons.visibility : Icons.visibility_off),
            onPressed: _toggleVisibility,
          ),
          
            ),
            obscureText: _isObscured,
            keyboardType:TextInputType.visiblePassword
          ),
            ],
          )
          ),
          ),
       ),
            
            CustomButton(text: 'Login',
            onPressed:(){
              _fromKey.currentState!.validate();
            }
            ,),
             const  SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 const  Text('New here?'),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, '/newsfeed');
                    },
                    child:
               const    Text('Signup',
                  style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),
                  ),
                  ),

                ],
              )
           ,
        ],
      ),
      ),
    );
  }
}
   