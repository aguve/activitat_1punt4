// city_name_screen.dart
import 'package:activitat_1punt4/styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:activitat_1punt4/models/postal_code_info.dart';
import 'package:activitat_1punt4/services/city_postal_code_service.dart';

class CityNameScreen extends StatefulWidget {
  const CityNameScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CityNameScreenState createState() => _CityNameScreenState();
}

class _CityNameScreenState extends State<CityNameScreen> {
  String _municipi = '';
  String _ccaa = '';
  List<PostalCodeInfo> _codisPostals = [];
  bool _isLoading = false;
  String? _error;
  final CityPostalCodeService _postalCodeService = CityPostalCodeService();

  // Llista de municipis suggerits
  final List<String> _municipisList = [
    'Torredembarra',
    'Calella',
    'Barcelona',
    'La Conca de Barberà',
    'El Masnou',
    'Riells',
    'Blanes',
    'Tarragona',
    'Lleida',
    'Girona',
    'Cantonigròs',
    'Olesa de Montserrat',
    'Olot',
    'Manlleu',
    'Miengo',
    'Mogro',
  ];

  // Funció que retorna els codis postals assossiats a un municipi donat
  Future<void> _buscarCodigosPostales(String sccaa, String municipi) async {
    setState(() {
      _isLoading = true;
      _error = null;
      _codisPostals = [];
    });

    try {
      final codis = await _postalCodeService.fetchPostalCodes(sccaa, municipi);

      setState(() {
        _codisPostals = codis;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  String? _selectedOption;
  final List<String> _options = [
    'Andalusia',
    'Aragó',
    'Asturies',
    'Balears',
    'Canaries',
    'Cantebria',
    'Castella i Lleó',
    'Castella la Manxa',
    'Catalunya',
    'Comunitat Valenciana',
    'Euskadi',
    'Extremadura',
    'Galicia',
    'Madrit',
    'Murcia',
    'Navarra',
    'Rioja',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'On Cau?',
          style: AppStyles.screenSubTitle,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '\nCodis postals d\'un municipi\n',
                style: AppStyles.screenTitle,
              ),
              /* TextField(
                decoration: const InputDecoration(
                  labelText: 'Escriu el nom del municipi',
                ),
                onChanged: (value) {
                  _municipi = value;
                },
              ), */
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  return _municipisList.where((String option) {
                    return option
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase());
                  });
                },
                onSelected: (String selection) {
                  setState(() {
                    _municipi = selection;
                  });
                },
                fieldViewBuilder: (BuildContext context,
                    TextEditingController textEditingController,
                    FocusNode focusNode,
                    VoidCallback onFieldSubmitted) {
                  return TextField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    decoration: const InputDecoration(
                      labelText: 'Escriu el nom del municipi',
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              DropdownButton<String>(
                value: _selectedOption,
                hint: const Text('Tria una CCAA'),
                items: _options.map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedOption = newValue;
                    _ccaa = _selectedOption.toString();
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_municipi.isNotEmpty && _ccaa.isNotEmpty) {
                    var comaut = '';
                    switch (_ccaa) {
                      case 'Andalusia':
                        comaut = 'an';
                        break;
                      case 'Aragó':
                        comaut = 'ar';
                        break;
                      case 'Asturies':
                        comaut = 'o';
                        break;
                      case 'Balears':
                        comaut = 'pm';
                        break;
                      case 'Canaries':
                        comaut = 'ca';
                        break;
                      case 'Cantebria':
                        comaut = 's';
                        break;
                      case 'Castella i Lleó':
                        comaut = 'cl';
                        break;
                      case 'Castella la Manxa':
                        comaut = 'cm';
                        break;
                      case 'Catalunya':
                        comaut = 'ct';
                        break;
                      case 'Comunitat Valenciana':
                        comaut = 'vc';
                        break;
                      case 'Euskadi':
                        comaut = 'pv';
                        break;
                      case 'Extremadura':
                        comaut = 'ex';
                        break;
                      case 'Galicia':
                        comaut = 'ga';
                        break;
                      case 'Madrit':
                        comaut = 'm';
                        break;
                      case 'Murcia':
                        comaut = 'mu';
                        break;
                      case 'Navarra':
                        comaut = 'na';
                        break;
                      case 'Rioja':
                        comaut = 'lo';
                        break;
                    }
                    _buscarCodigosPostales(comaut, _municipi);
                  }
                },
                child: Text(
                  'Cerca Codis Postals',
                  style: AppStyles.buttonsText,
                ),
              ),
              const SizedBox(height: 20),
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else if (_error != null)
                Center(
                  child: Text(
                    _error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: _codisPostals.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_codisPostals[index].postCode),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
