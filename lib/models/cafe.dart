class Cafe {
  final String id;
  final String name;
  final String vicinity;
  final double latitude;
  final double longitude;
  final List<String> photos;
  double? distance;
  final double rating;
  final double maxprice;
  // Updated the 'distance' attribute to be nullable

  Cafe({
    required this.id,
    required this.name,
    required this.vicinity,
    required this.latitude,
    required this.longitude,
    required this.photos,
    required this.rating,
    required this.maxprice
  });

  factory Cafe.fromGooglePlaces(Map<String, dynamic> json) {
    // Extract latitude and longitude
    final lat = json['geometry']['location']['lat'];
    final lng = json['geometry']['location']['lng'];

    // Extract photo reference if available
    final photoRef = json['photos'] != null
        ? json['photos'][0]['photo_reference']
        : null;

    final rating = json['rating'] != null ? json['rating'].toDouble() : null;
    final maxprice = json['maxprice'] != null ? json['maxprice'].toDouble() : null;

    // Build photo URLs
    final List<String> photoUrls = [];

    if (photoRef != null) {
      photoUrls.add(photoRef); // Store only the photo reference
    }

    return Cafe(
      id: json['place_id'],
      name: json['name'],
      vicinity: json['vicinity'],
      latitude: lat,
      longitude: lng,
      photos: photoUrls,
      rating: rating,
      maxprice: maxprice ?? 3,
    );
  }
}