import 'dart:convert';
import 'dart:math' as math;
import 'package:meshigacha/models/cafe.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_functions/cloud_functions.dart';

Map<String, dynamic> convertMap(Map<Object?, Object?> originalMap) {
  final Map<String, dynamic> convertedMap = {};

  originalMap.forEach((key, value) {
    // キーがnullでないこと、そしてStringに変換可能であることを確認
    if (key is String) {
      convertedMap[key] = value;
    } else {
      // ここでキーがStringではない場合の処理を行う
      // 例: エラーを投げる、ログに記録する、デフォルトのキーを使用する等
      throw Exception('Key is not a string: $key');
    }
  });

  return convertedMap;
}

class CafeService {
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

  Future<List<Cafe>> fetchNearbyCafes(
      double latitude,
      double longitude,
      double radius,
      String inputCategory,
      ) async {
    final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('fetchNearbyCafes');
    final response = await callable.call(<String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
      'radius': radius,
      'inputCategory': inputCategory,
    });

    if (response.data == null) {
      throw Exception('Failed to fetch nearby cafes');
    }

    final List<dynamic> results = response.data['cafes'];

    final List<Cafe> cafes = results.map((result) {
      // ここでMap<Object?, Object?>をMap<String, dynamic>に変換
      if (result is Map<Object?, Object?>) {
        final convertedResult = convertMap(result);
        return Cafe.fromGooglePlaces(convertedResult);
      } else {
        throw Exception('Invalid data format');
      }
    }).where((cafe) => cafe.rating != null && cafe.rating >= 3.5) // 評価が3.5以上のカフェのみフィルタリング
        .where((cafe) => cafe.maxprice != null && cafe.maxprice <= 4) // maxpriceが4以下の居酒屋のみフィルタリング
        .toList();

    // Assign computed distances to each cafe object
    for (Cafe cafe in cafes) {
      cafe.distance = computeDistance(latitude, longitude, cafe.latitude, cafe.longitude);
    }

    return cafes;
  }
}