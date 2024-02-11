import 'package:flutter/material.dart';
import 'package:meshigacha/models/cafe.dart';
import 'package:meshigacha/screens/gacha_animation_screen.dart';
import 'package:meshigacha/services/cafe_service.dart';
import 'package:meshigacha/services/location_service.dart';


//ガチャを引く画面
class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  double _selectedDistance = 500.0;
  List<double> sliderValues = [100, 200, 300, 400, 500, 600, 700, 800, 900, 1000];
  TextEditingController categoryController = TextEditingController();

  Future<void> _getStarted(BuildContext context, String inputCategory) async {
    bool permissionGranted = await LocationService().requestPermission();
    String inputCategory =  categoryController.text;

    if (inputCategory.isEmpty) {
      inputCategory = "居酒屋";
      // 入力が空の場合、デフォルトでinputCategoryに”居酒屋”が入る
    }

    if (permissionGranted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GachaAnimationScreen(
            selectedDistance: _selectedDistance,
            inputCategory: inputCategory,
            onNoCafesFound: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('No cafes found within the selected range.'),
                ),
              );
            },
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Location permission is required for the app to work.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    String inputCategory = '';

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('飯ガチャ',
          style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'DelaGothicOne'
          ),
        ),
        backgroundColor: const Color(0xFF7ED957),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 32.0),
              const Text('Welcome  to  飯ガチャ!!',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'DelaGothicOne',
                  color: Color(0xFF7ED957),
                ),
              ),
              const SizedBox(height: 64.0),
              const Text('❶ まず、スライダーで距離を設定してください！',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NotoSansJP',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Container(
                width: 350,
                child: Slider(
                  activeColor: Colors.black,
                  inactiveColor: Colors.grey,
                  value: _selectedDistance,
                  min: 100,
                  max: 1000,
                  onChanged: (double value) {
                    setState(() {
                      _selectedDistance = sliderValues.reduce((a, b) =>
                      (value - a).abs() < (value - b).abs() ? a : b);
                    });
                  },
                ),
              ),
              Text(
                '${_selectedDistance.toInt()}m圏内',
                style: const TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'DelaGothicOne',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 70.0),
              const Text('❷ 次に、行きたいお店の種類を教えてください！',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NotoSansJP',
                ),
                textAlign: TextAlign.center,
              ),
              const Text('※入力しなくても大丈夫です！',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NotoSansJP',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40.0),
              Container(
                alignment: Alignment.center,
                width: 250,
                child: Column(
                  children: [
                    Padding(
                      padding:EdgeInsets.fromLTRB(20, 0, 20, 30),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: "Keyword",
                          hintText: "(例) 海鮮居酒屋",
                        ),
                        controller: categoryController,
                        onChanged: (text) {
                          setState(() {
                            inputCategory = text;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                height: 60.0,
                width: 300.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF7ED957),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () => _getStarted(context, inputCategory),
                  child: const Text('ガチャを引く',
                    style: TextStyle(
                      fontSize: 19.0,
                      fontFamily: 'NotoSansJP',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}