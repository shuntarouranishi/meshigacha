import 'dart:convert';
import 'dart:math' as math;
import 'package:cafe_gacha/models/cafe.dart';
import 'package:http/http.dart' as http;

class CafeService {
  // Replace this with your actual API key
  final String apiKey = 'AIzaSyBsDHGQOJMaCjubsXeUCksfDTCGbQC1Y4U';

  double computeDistance(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371e3; // Earth radius in meters

    double rad(double deg) {
      return deg * (math.pi / 180);
    }

    double dLat = rad(lat2 - lat1);
    double dLon = rad(lon2 - lon1);

    double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(rad(lat1)) * math.cos(rad(lat2)) * math.sin(dLon / 2) * math.sin(dLon / 2);

    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return R * c;
  }

  Future<List<Cafe>> fetchNearbyCafes(double latitude, double longitude, double radius) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=$radius&type=cafe&key=$apiKey&language=ja';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> results = jsonDecode(response.body)['results'];

      if (results.isEmpty) {
        throw Exception('No cafes found');
      }

      final List<Cafe> cafes = results
          .map((result) => Cafe.fromGooglePlaces(result, apiKey))
          .toList();

      // Assign computed distances to each cafe object
      for (Cafe cafe in cafes) {
        cafe.distance = computeDistance(latitude, longitude, cafe.latitude, cafe.longitude);
      }

      return cafes;
    } else {
      throw Exception('Failed to fetch nearby cafes');
    }
  }

}
