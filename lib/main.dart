import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meshigacha/widgets/app_theme.dart';
import 'package:meshigacha/screens/login_screen.dart';
import 'dart:js' as js;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCHuWAPNt2XP2GW5LIf5d-72KG7Pczrw9U",
      authDomain: "torima-4a05c.firebaseapp.com",
      projectId: "torima-4a05c",
      storageBucket: "torima-4a05c.appspot.com",
      messagingSenderId: "817720033710",
      appId: "1:817720033710:web:0245abc748865d1be4883f",
      measurementId: "G-N1YFG04D0E",
    ),
  );
  runApp(MeshiGachaApp());
}

class MeshiGachaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meshi Gacha',
      theme: appTheme,
      home: LoginPage(),
    );
  }
}
