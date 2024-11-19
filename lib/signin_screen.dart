import 'package:flutter/material.dart';
import 'color_utils.dart';
import 'package:lottie/lottie.dart';
import 'reusable_text_field.dart';
import 'signup_screen.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

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
          hexStringToColor("CB2893"),
          hexStringToColor("9546C4"),
          hexStringToColor("5E61F4"),
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
            signInSignUpButton(context, true, () {}),
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

