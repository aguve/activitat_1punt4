// postal_code_info.dart
class PostalCodeInfo {
  final String postCode;

  PostalCodeInfo({required this.postCode});

  // Crear una instancia desde JSON
  factory PostalCodeInfo.fromJson(Map<String, dynamic> json) {
    return PostalCodeInfo(
      postCode: json['post code'],
    );
  }
}
