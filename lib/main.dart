import 'package:final_exam/view/homePage.dart';
import 'package:final_exam/view/login/sign-in.dart';
import 'package:final_exam/view/login/sign-up.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
     getPages: [
       GetPage(name: '/', page: () => SignIn(),),
       GetPage(name: '/home', page: () => HomePage(),),
       GetPage(name: '/signUp', page: () => SignUp(),),
     ],
    );

  }
}



