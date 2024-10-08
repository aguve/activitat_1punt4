// city_postal_code_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:activitat_1punt4/models/postal_code_info.dart';

class CityPostalCodeService {
  Future<List<PostalCodeInfo>> fetchPostalCodes(
      String regionCode, String cityName) async {
    final url = Uri.parse('https://api.zippopotam.us/es/$regionCode/$cityName');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<PostalCodeInfo> postalCodes = [];

        for (var place in data['places']) {
          postalCodes.add(PostalCodeInfo.fromJson(place));
        }

        return postalCodes;
      } else {
        throw Exception('Codi postal no trobat');
      }
    } catch (e) {
      throw Exception('Error al connectar amb la API');
    }
  }
}
