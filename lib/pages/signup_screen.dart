import 'package:flutter/material.dart';
import 'package:newsfeed/themes/colors.dart';
import 'package:newsfeed/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newsfeed/widgets/snack_bar.dart';

class SignupScreen extends StatefulWidget {
 SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController= TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      try {
      
        // Create user with email and password
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // Save additional user details in Firestore
        await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
          'name': _nameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
        });

        // Show a confirmation message
        ShowSnackBar(context, 'User Registered Successfully');
         Navigator.pushNamed(context, '/newsfeed');
        // Clear the form
        _nameController.clear();
        _emailController.clear();
        _passwordController.clear();
      } on FirebaseAuthException catch (e) {
        ShowSnackBar(context, 'User Already Exist');
        if (e.code == 'weak-password') {
          ShowSnackBar(context, 'The Password Provided Is Too Weak.');
        } else if (e.code == 'email-already-in-use') {
        //  ShowSnackBar(context, 'The account already exists for that email.');
        } else if (e.code == 'invalid-email') {
          ShowSnackBar(context, 'The E-mail Is Invalid.');
        }

        // Show error message
        } catch (e) {
      }
    }
  }


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
    return Scaffold(
      backgroundColor: bodybg,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('MyNews',
                     style: TextStyle(color: Color.fromARGB(255,12, 84, 190),
                    fontWeight: FontWeight.bold),
                    ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(padding:  EdgeInsets.all(12),
      child:
      Column(
        children: [
          Expanded(
            child: 
          Center(child:
          Form(
            key: _formKey,
            child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
          TextFormField(
            validator: (name)=> name!.length<3 ? 'Name must be at least 3 characters long' : null,
            controller: _nameController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Name',
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
            keyboardType:TextInputType.name,
          ),
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
           TextFormField(
            validator: (password)=> password!.length<5 ? 'Password must be at least 5 characters long' : null,
            controller: _passwordController,
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
            
            CustomButton(text: 'Signup',
            onPressed:(){
              print('pressed');
              _formKey.currentState!.validate();
              _registerUser();
            }
            ,),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Alredy have an account?'),
                  GestureDetector(
                    onTap:(){
                    Navigator.pushNamed(context, '/login');
                    },
                    child:
                 Text('Login',
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