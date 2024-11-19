import 'package:flutter/material.dart';
import 'package:my_final_project/color_utils.dart';
import 'package:my_final_project/reusable_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignupScreenState();
}



class _SignupScreenState extends State<SignUpScreen> {
  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  void dispose() {
    _userNameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),

      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(gradient: LinearGradient(colors: [
          hexStringToColor("CB2893"),
          hexStringToColor("9546C4"),
          hexStringToColor("5E61F4"),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(child: Padding(
          padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.2, 20, 0),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height:20,
              ),
              reusableTextField("Enter UserName", Icons.person_outline, false,
                  _userNameTextController),
              const SizedBox(
                height:20,
              ),
              reusableTextField("Enter Email Id", Icons.email_outlined, false,
                  _emailTextController),
              const SizedBox(
                height:20,
              ),
              reusableTextField("Enter Password", Icons.lock_outline, true,
                  _passwordTextController),
              const SizedBox(
                height:20,
              ),
              signInSignUpButton(context, false, () {
                Navigator.pop(context);

              }),
            ],
          ),
        ))
      ),
    );
  }
}

