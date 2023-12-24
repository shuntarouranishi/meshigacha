import 'package:flutter/material.dart';
import 'package:meshigacha/models/cafe.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:meshigacha/screens/welcome_screen.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_functions/cloud_functions.dart';

class CafeInfoScreen extends StatelessWidget {
  final Cafe cafe;
  final double distance;

  const CafeInfoScreen({required this.cafe, required this.distance});

  Future<String> fetchCafeImageUrl(String photoReference) async {
    final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('fetchCafeImageUrl');
    final response = await callable.call(<String, dynamic>{
      'photoReference': photoReference,
    });
    if (response.data == null) {
      throw Exception('Failed to fetch cafe image URL');
    }
    return response.data['imageUrl'];
  }

  Widget buildCafeImage(BuildContext context) {
    // `FutureBuilder`を使用して非同期処理を処理
    return FutureBuilder<String>(
      future: cafe.photos.isNotEmpty ? fetchCafeImageUrl(cafe.photos[0]) : Future.value('path_to_default_image'),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // ロード中はインジケータを表示
        } else if (snapshot.hasError) {
          return const Icon(Icons.error); // エラー時はエラーアイコンを表示
        } else {
          return CachedNetworkImage(
            imageUrl: snapshot.data!,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          );
        }
      },
    );
  }

  Future<void> _openGoogleMaps(double latitude, double longitude) async {
    final String googleMapsUrl = 'https://maps.google.com/?q=$latitude,$longitude';
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        const Text('IZAKAYA-ガチャ',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'DelaGothicOne',
          ),
        ),
        backgroundColor: const Color(0xFF7ED957),//0x＋FF＋7CD157
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50.0),
                Container(
                  width: 400,
                  height: 50,
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 14.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(cafe.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSansJP',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                    width: 400,
                    height: 400,
                    child: buildCafeImage(context)),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 400,
                      height: 90,
                      padding: EdgeInsets.only(top: 13),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        children: [
                          Text('${cafe.vicinity}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontFamily: 'NotoSansJP',
                            ),
                            textAlign: TextAlign.center,
                          ),
                          TextButton(
                            onPressed: () {
                              _openGoogleMaps(cafe.latitude, cafe.longitude);
                            },
                            child: const Text('Googleマップで開く',
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'NotoSansJP',
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Text(
                  '現在地からの距離：${distance.round()} m',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NotoSansJP',
                  ),),
                SizedBox(height: 30.0),
                SizedBox(
                  height: 60.0,
                  width: 200.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF7ED957),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => WelcomeScreen()),
                      );
                    },
                    child: const Text('もう一度探す',
                      style: TextStyle(
                        fontSize: 19.0,
                        fontFamily: 'NotoSansJP',
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Color(0xFFE4F4D0),
                  child: SizedBox(
                    height: 30.0,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  child: const Text('友人と行く居酒屋選び、それがランダムでもいい。',
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSansJP',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: 120, // Set the desired width
                  height: 120, // Set the desired height
                  child: Image.asset('images/cafe-icon.jpg', fit: BoxFit.cover),
                ),
                const Text('IZAKAYA-ガチャ',
                  style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DelaGothicOne',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}