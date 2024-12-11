import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:my_final_project/signin_screen.dart';
import 'package:flutter/foundation.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(options: FirebaseOptions(apiKey:"AIzaSyAnnl_Km_R00Yel_GZXp0UarQb-IRLPqnc", appId: "1:787693849749:web:8d490f36536e3764de9f9c", messagingSenderId: "787693849749", projectId: "pgscout-2e46e"));}
    else {
      await Firebase.initializeApp();

  }

  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SigninScreen(),
    );
  }
}
