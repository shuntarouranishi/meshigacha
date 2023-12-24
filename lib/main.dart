import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';  // Firebaseをインポート
import 'package:meshigacha/widgets/app_theme.dart';
import 'package:meshigacha/screens/login_screen.dart';  // LoginPageをインポート

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // Flutterバインディングの初期化
  await Firebase.initializeApp();  // Firebaseの初期化
  runApp(MeshiGachaApp());
}

class MeshiGachaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meshi Gacha',  // アプリのタイトル
      theme: appTheme,       // アプリのテーマ
      home: LoginPage(),     // 最初に表示される画面をLoginPageに変更
    );
  }
}
