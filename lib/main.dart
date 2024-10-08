import 'package:activitat_1punt4/screens/postal_code_screen.dart';
import 'package:activitat_1punt4/styles/app_styles.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const PostalApp());
}

class PostalApp extends StatelessWidget {
  const PostalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'On Cau?',
      theme: AppStyles.themeData,
      home: const PostalCodeScreen(),
    );
  }
}
