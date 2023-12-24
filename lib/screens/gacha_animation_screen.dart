import 'dart:async';
import 'dart:math' as math; // Add this line
import 'package:flutter/material.dart';
import 'package:meshigacha/models/cafe.dart';
import 'package:meshigacha/screens/cafe_info_screen.dart';
import 'package:meshigacha/services/cafe_service.dart';
import 'package:meshigacha/services/location_service.dart';
import 'package:geolocator/geolocator.dart';

import '../services/cafe_service.dart';

class GachaAnimationScreen extends StatefulWidget {
  final double selectedDistance;
  final VoidCallback onNoCafesFound;
  final String inputCategory;

  const GachaAnimationScreen({
    required this.selectedDistance,
    required this.onNoCafesFound,
    required this.inputCategory, // Add this line
  });

  @override
  _GachaAnimationScreenState createState() => _GachaAnimationScreenState();
}


class _GachaAnimationScreenState extends State<GachaAnimationScreen> {
  final LocationService locationService = LocationService();
  final CafeService cafeService = CafeService();

  @override
  void initState() {
    super.initState();
    performGacha();
  }

  Future<bool> performGacha() async {
    try {
      Position position = await locationService.getCurrentLocation();
      List<Cafe> cafes = await cafeService.fetchNearbyCafes(
        position.latitude,
        position.longitude,
        widget.selectedDistance,
        widget.inputCategory,
      );
      Cafe? selectedCafe = chooseRandomCafe(cafes);

      if (selectedCafe != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CafeInfoScreen(
              cafe: selectedCafe,
              distance: selectedCafe.distance!,
            ),
          ),
        );
        return true;
      } else {
        widget.onNoCafesFound();
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Cafe? chooseRandomCafe(List<Cafe> cafes) {
    final filteredCafes = cafes.where((cafe) => cafe.distance! <= widget.selectedDistance).toList();

    if (filteredCafes.isEmpty) {
      return null;
    } else {
      final random = math.Random();
      int randomIndex = random.nextInt(filteredCafes.length);
      return filteredCafes[randomIndex];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}