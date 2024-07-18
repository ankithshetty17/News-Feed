import 'package:flutter/material.dart';
import 'package:newsfeed/themes/colors.dart';
import 'package:newsfeed/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newsfeed/widgets/snack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscured = true;
// Toggle Iocn For Password
  void _toggleVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }
//Function For Validation Of Email
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

  Future<void> _loginUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Sign in user with email and password
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // Navigate to next page after successful login
        Navigator.pushNamed(context, '/newsfeed');
      } on FirebaseAuthException catch (e) {
        ShowSnackBar(context, 'Wrong E-mail Or Password');
        if (e.code == 'user-not-found') {
          // message = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          ShowSnackBar(context, 'Wrong E-mail Or Password');
        }

        // Show error message
        // ShowSnackBar(context, 'Wrong E-mail Or Password');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodybg,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:const  Text(
          'MyNews',
          style: TextStyle(
            color: Color.fromARGB(255, 12, 84, 190),
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding:const  EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    const   SizedBox(height: 10),
                      TextFormField(
                        controller: _emailController,
                        decoration:const  InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'E-mail',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.transparent),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15)),
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: _validateEmail,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        validator: (password) => password!.length < 5
                            ? 'Password must be at least 5 characters long'
                            : null,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Password',
                          enabledBorder:const  OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.transparent),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15)),
                          ),
                          border:const  OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          focusedBorder:const  OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15)),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                                _isObscured ? Icons.visibility : Icons.visibility_off),
                            onPressed: _toggleVisibility,
                          ),
                        ),
                        obscureText: _isObscured,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            CustomButton(
              text: 'Login',
              onPressed: () {
                _formKey.currentState!.validate();
                _loginUser();
              },
            ),
          const   SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               const  Text('New here?'),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child:const  Text(
                    'Signup',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
