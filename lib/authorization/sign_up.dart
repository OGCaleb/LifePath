import 'package:flutter/material.dart';
import 'package:myapp/authorization/sign_up_controller.dart';


class SignUpScreen extends StatefulWidget {
 const SignUpScreen({super.key});


 @override
 State<SignUpScreen> createState() => _SignUpScreenState();
}


class _SignUpScreenState extends State<SignUpScreen> {
 final TextEditingController _emailController = TextEditingController();
 final TextEditingController _passwordController = TextEditingController();
 final SignUpController _signUpController = SignUpController();
 final _formKey = GlobalKey<FormState>();


  bool _passwordVisible = false;


 String? _validateemail(String? value) {
   if (value == null || value.isEmpty) {
     return 'Please enter your email';
   }
   const String pattern =
       r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$";
   final RegExp regex = RegExp(pattern);
   if (!regex.hasMatch(value)) {
     return 'Enter a valid email address';
   }
   return null;
 }


 String? _validatePassword(String? value) {
   if (value == null || value.isEmpty) {
     return 'Please enter a password';
   }
   if (value.length < 8) {
     return 'Password must be at least 8 characters';
   }
   return null;
 }
 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: const Text("Sign Up"),
     ),
     body: Padding(
       padding: const EdgeInsets.all(16.0),
       child: Form(
         key: _formKey,
         child: ListView(
           children: <Widget>[
             const SizedBox(height: 20),
             TextFormField(
               controller: _emailController,
               decoration: const InputDecoration(
                 labelText: 'Email',
                 hintText: 'Enter your email',
                 border: OutlineInputBorder(),
                 errorBorder: OutlineInputBorder(
                   borderSide: BorderSide(color: Colors.red),
                 ),
               ),
               validator: _validateemail,
             ),
             const SizedBox(height: 20),
             TextFormField(
               controller: _passwordController,
               decoration: InputDecoration(
                 labelText: 'Create a password',
                 hintText: 'Must be 8 characters or more',
                 border: OutlineInputBorder(),
                 suffixIcon: IconButton(
                   icon: Icon(
                     _passwordVisible
                         ? Icons.visibility
                         : Icons.visibility_off,
                   ),
                   onPressed: () {
                     setState(() {
                       _passwordVisible = !_passwordVisible;
                     });
                   },
                 ),
                 errorBorder: OutlineInputBorder(
                   borderSide: BorderSide(color: Colors.red),
                 ),
               ),
               obscureText: !_passwordVisible,
               validator: _validatePassword,
             ),
             const SizedBox(height: 20),
             ElevatedButton(
               onPressed: () {
                 if (_formKey.currentState!.validate()) {
                   _signUpController.completeSignUp(
                    _emailController.text, 
                   _passwordController.text
                   );
                   Navigator.pushReplacementNamed(context, '/dashboard');
                 } else {
                   ScaffoldMessenger.of(context).showSnackBar(
                     const SnackBar(
                       content: Text('Please fill in all fields'),
                     ),
                   );
                 }
               },
               child: const Text('Complete sign up'),
             ),
             const SizedBox(height: 20),
             ElevatedButton(
               onPressed: () {
                 Navigator.pushReplacementNamed(context, '/login');
               },
               child: const Text('Sign in instead'),
             ),
           ],
         ),
       ),
     ),
   );
 }
}
