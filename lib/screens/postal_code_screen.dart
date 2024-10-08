// postal_code_screen.dart
import 'package:activitat_1punt4/models/location_data.dart';
import 'package:activitat_1punt4/screens/city_name_screen.dart';
import 'package:activitat_1punt4/services/postal_code_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PostalCodeScreen extends StatefulWidget {
  const PostalCodeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PostalCodeScreenState createState() => _PostalCodeScreenState();
}

class _PostalCodeScreenState extends State<PostalCodeScreen> {
  final TextEditingController _postalCodeController = TextEditingController();
  final PostalCodeService _postalCodeService = PostalCodeService();
  LocationData? _locationData;
  bool _loading = false;
  String? _errorMessage;

  // Funció per obrir Google Maps
  Future<void> _openMaps() async {
    final lat = _locationData?.latitude;
    final lon = _locationData?.longitude;

    final googleMapsWebUrl = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$lat,$lon&zoom=10');
    final googleMapsAppUrl = Uri.parse('geo:$lat,$lon?q=$lat,$lon&z=10');

    if (await canLaunchUrl(googleMapsAppUrl)) {
      await launchUrl(googleMapsAppUrl);
    } else if (await canLaunchUrl(googleMapsWebUrl)) {
      await launchUrl(googleMapsWebUrl);
    } else {
      throw 'No s\'ha pogut obrir Google Maps.';
    }
  }

  // Funció per obtenir les dades del municipi
  Future<void> _fetchCityName() async {
    final postalCode = _postalCodeController.text.trim();
    if (postalCode.isEmpty) return;

    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    final locationData = await _postalCodeService.fetchCityName(postalCode);

    if (locationData != null) {
      setState(() {
        _locationData = locationData;
        _loading = false;
      });
    } else {
      setState(() {
        _errorMessage = 'Codi postal no trobat';
        _loading = false;
        _locationData = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On Cau?'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Cerca un municipi\n',
              style: TextStyle(fontSize: 19),
            ),
            TextField(
              controller: _postalCodeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Codi Postal',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _fetchCityName,
                  child: const Text('Cerca un municipi'),
                ),
                const SizedBox(width: 10),
                if (_locationData != null)
                  ElevatedButton(
                    onPressed: _locationData?.latitude != null &&
                            _locationData?.longitude != null
                        ? _openMaps
                        : null,
                    child: const Text('Veure a\nGoogle Maps'),
                  ),
              ],
            ),
            const SizedBox(height: 24),
            if (_loading) const CircularProgressIndicator(),
            if (_errorMessage != null)
              Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
            if (_locationData != null)
              Text(
                'Municipi: ${_locationData?.placeName}'
                '\nLatitud: ${_locationData?.latitude}'
                '\nLongitud: ${_locationData?.longitude}',
                style: const TextStyle(fontSize: 20),
              ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CityNameScreen(),
                  ),
                );
              },
              child: const Text('Cerca per municipi'),
            ),
          ],
        ),
      ),
    );
  }
}
