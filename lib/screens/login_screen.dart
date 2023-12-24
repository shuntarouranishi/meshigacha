import 'package:flutter/material.dart';
import 'package:meshigacha/screens/welcome_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        const Text('IZAKAYA-ガチャ',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'DelaGothicOne',
          ),
        ),
        backgroundColor: const Color(0xFF7ED957),//0x＋FF＋7CD157
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 32.0),
            Container(
              child: const Text('友人と行く居酒屋選び、それがランダムでもいい。',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NotoSansJP',
                  color: Color(0xFF7ED957),
                ),
              ),
            ),
            Container(
              child: const Text('IZAKAYA-ガチャ',
                style: TextStyle(
                  fontSize: 26.0,
                  fontFamily: 'DelaGothicOne',
                  color: Color(0xFF7ED957),
                ),
              ),
            ),
            Container(
              width: 200, // Set the desired width
              height: 200, // Set the desired height
              child: Image.asset('images/izakaya-icon.jpg', fit: BoxFit.cover),
            ),
            SizedBox(height: 5.0,),
            Container(
              child: const Text('IZAKAYA-ガチャはカジュアルな居酒屋選びを\nランダム性により、簡単に面白くしてくれます',
                style: TextStyle(
                  fontSize: 13.0,
                  fontFamily: 'NotoSansJP',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 60.0),
            SizedBox(
              height: 60,
              width: 350,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF7ED957),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
                    );
                  },
                  child: const Text('はじめる',
                    style: TextStyle(
                      fontFamily: 'NotoSansJP',
                      fontSize: 19.0,
                    ),
                  )
              ),
            ),
            const SizedBox(height: 70.0),
            Container(
              width: double.infinity,
              height: 70.0,
              color: const Color(0xFFE4F4D0),//E4F4D0FF
              padding: const EdgeInsets.all(20.0),
              child: Text('IZAKAYA-ガチャの２つの特徴',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'NotoSansJP',
                ),
              ),
            ),
            Container(
              color: Color(0xFFE4F4D0),
              width: double.infinity,
              child: Column(
                children: [
                  Image.asset(
                    width: 100,
                    height: 100,
                    'images/entertainment-icon.jpg',
                  ),
                  SizedBox(height: 8),
                  Text(
                    'エンタメ性',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSansJP',
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'お店選びが\nよりエンターテインメントになります',
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSansJP',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              color: Color(0xFFE4F4D0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "images/partition.jpg",
                    width: 50,
                    height: 50,
                  ),
                  Image.asset(
                    "images/partition.jpg",
                    width: 50,
                    height: 50,
                  ),
                  Image.asset(
                    "images/partition.jpg",
                    width: 50,
                    height: 50,
                  ),
                  Image.asset(
                    "images/partition.jpg",
                    width: 50,
                    height: 50,
                  ),Image.asset(
                    "images/partition.jpg",
                    width: 50,
                    height: 50,
                  ),
                  Image.asset(
                    "images/partition.jpg",
                    width: 50,
                    height: 50,
                  ),Image.asset(
                    "images/partition.jpg",
                    width: 50,
                    height: 50,
                  ),
                ],
              ),
            ),
            Container(
              color: Color(0xFFE4F4D0),
              width: double.infinity,
              child: Column(
                children: [
                  Image.asset(
                    width: 100,
                    height: 100,
                    'images/new-encounter-icon.jpg',
                  ),
                  SizedBox(height: 8),
                  const Text(
                    '新たな発見',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSansJP',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  const Text(
                    'まだ知らない\n名店に出会うことができるかもしれません',
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSansJP',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(
                color: Color(0xFFE4F4D0),
                child: SizedBox(width: double.infinity, height: 40)),
            Container(
                child: SizedBox(width: double.infinity, height: 40)),
          ],
        ),
      ),
    );
  }
}