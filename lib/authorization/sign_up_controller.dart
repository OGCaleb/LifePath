import 'package:firebase_auth/firebase_auth.dart';


class SignUpController {
 // ignore: unused_field
 late String _email;
 // ignore: unused_field
 late String _password;


 void setEmail(String newEmail) {
   _email = newEmail;
 }


 void setPassword(String newPassword) {
   _password = newPassword;
 }


 Future<void> completeSignUp(String email, String password) async {
     if(email.isNotEmpty && password.isNotEmpty) {
       await createNewFirebaseUser(email, password);
     } else {
       print("Incomplete sign up info");
     }
 }
  
 Future<void> createNewFirebaseUser(String email, String password) async {
     try {
       UserCredential userCredential = await FirebaseAuth.instance
           .createUserWithEmailAndPassword(
         email: email,
         password: password,
       );
       User? user = userCredential.user;
       if (user != null) {
         print(
             'user created with UID: ${user.uid} and email: ${user.email}');
       } else {
         print("No user was created");
       }
     } on FirebaseAuthException catch (e) {
       print('Error creating user: $e');
     }
 }
}
