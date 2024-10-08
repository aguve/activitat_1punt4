// postal_code_service.dart
import 'dart:convert';
import 'package:activitat_1punt4/models/location_data.dart';
import 'package:http/http.dart' as http;

class PostalCodeService {
  Future<LocationData?> fetchCityName(String postalCode) async {
    final url = Uri.parse('https://api.zippopotam.us/es/$postalCode');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return LocationData.fromJson(data);
      } else {
        // Retorna null si no troba el codi postal
        return null;
      }
    } catch (e) {
      throw Exception('Error al connectar amb la API');
    }
  }
}
