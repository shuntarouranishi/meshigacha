import 'package:flutter/material.dart';
import 'package:cafe_gacha/models/cafe.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cafe_gacha/screens/welcome_screen.dart';

class CafeInfoScreen extends StatelessWidget {
  final Cafe cafe;
  final double distance;

  CafeInfoScreen({required this.cafe, required this.distance});

  Widget buildCafeImage(BuildContext context) {
    if (cafe.photos.isNotEmpty) {
      final String apiKey = 'AIzaSyBsDHGQOJMaCjubsXeUCksfDTCGbQC1Y4U'; // Put your Google Maps API Key here
      final String imageUrl =
          'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${cafe.photos[0]}&key=$apiKey';

      // Temporarily use Image.network() instead of CachedNetworkImage
      return Image.network(imageUrl);
    } else {
      return Icon(Icons.image_not_supported);
    }
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
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView( // Add this line
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(cafe.name, style: TextStyle(fontSize: 24)),
              Text(cafe.vicinity, style: TextStyle(fontSize: 16)),
              SizedBox(height: 16),
              buildCafeImage(context),
              SizedBox(height: 16),
              Text(
                '現在地からの距離: ${distance.round()} m', // Use distance.round() to display distance as a whole number
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  _openGoogleMaps(cafe.latitude, cafe.longitude);
                },
                child: Text('Googleマップで開く'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()),
                  );
                },
                child: Text('もう一度探す'),
              ),
            ],
          ),
        ),
      ), // Add this line
    );
  }
}
