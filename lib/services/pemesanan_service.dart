import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travelapp/models/pemesanan.dart';

class PemesananService {
  final String _baseUrl =
      "https://yourapi.com/api/pemesanan"; // GANTI ke URL YANG VALID

  Future<int> createPemesanan(Pemesanan pemesanan) async {
    final url = Uri.parse(_baseUrl); // PASTIKAN tidak ada tambahan lagi

    print("Mengirim ke URL: $url");
    print("Body: ${jsonEncode(pemesanan.toMap())}");

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(pemesanan.toMap()),
    );

    print("Response code: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data['id'];
    } else {
      throw Exception(
        "Gagal membuat pemesanan, error code: ${response.statusCode}",
      );
    }
  }
}
