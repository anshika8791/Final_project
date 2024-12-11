import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'reusable_text_field.dart';
import 'signup_screen.dart';
import 'home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  Future<void> login(String email, String password) async {
    try {
      // Sign in with email and password
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('User logged in: ${userCredential.user?.email}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login Successful')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided.';
      } else {
        message = e.message ?? 'An error occurred.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PG Scout', style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        )),
        centerTitle: true,
        backgroundColor: Colors.purple[400],
      ),
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(colors: [
          Color(0xffCB2893),
          Color(0xff9546C4),
          Color(0xff5E61F4),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height:250,
              child: Lottie.network(
                  "https://lottie.host/d28823c3-5228-4859-b4b7-fedc6d82acbb/UgdtccyWf1.json",
                  ),
            ),
            reusableTextField("Enter UserName", Icons.person_outline, false,
                _emailTextController),
            const SizedBox(
              height: 20,
            ),
            SizedBox(height: 20),
            reusableTextField("Enter Password", Icons.lock_outline, true,
                _passwordTextController),
            SizedBox(
              height: 20,
            ),
            signInSignUpButton(context, true, () {
            login(_emailTextController.text, _passwordTextController.text);
            }),
            signUpOption()
            ],
        ),
      ),
    );
  }

  Row signUpOption() {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        const Text("Don't have account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child:const Text(
            "Sign Up",
            style: TextStyle(color: Colors.white, fontWeight:FontWeight.bold),
          ),
        )
      ],
    );
  }
}

