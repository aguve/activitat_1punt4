// location_data.dart
class LocationData {
  final String postCode;
  final String country;
  final String countryAbbreviation;
  final String placeName;
  final String state;
  final String stateAbbreviation;
  final String latitude;
  final String longitude;

  LocationData({
    required this.postCode,
    required this.country,
    required this.countryAbbreviation,
    required this.placeName,
    required this.state,
    required this.stateAbbreviation,
    required this.latitude,
    required this.longitude,
  });

  // Constructor que crea una instància des de JSON
  factory LocationData.fromJson(Map<String, dynamic> json) {
    return LocationData(
      postCode: json['post code'],
      country: json['country'],
      countryAbbreviation: json['country abbreviation'],
      placeName: json['places'][0]['place name'],
      state: json['places'][0]['state'],
      stateAbbreviation: json['places'][0]['state abbreviation'],
      latitude: json['places'][0]['latitude'],
      longitude: json['places'][0]['longitude'],
    );
  }
}
