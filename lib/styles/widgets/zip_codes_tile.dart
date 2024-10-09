import 'package:activitat_1punt4/styles/app_styles.dart';
import 'package:flutter/material.dart';

//  Definició de les targetes que es fan servir per mostrar els codis postals
Widget zipCodeTile(String zipCode) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0), // Ajusta la mida de la tarjeta
      child: Center(
        child: Text(
          zipCode,
          style: AppStyles.zipCode,
          textAlign: TextAlign.center, // Centra el text dins la tarjeta
        ),
      ),
    ),
  );
}
