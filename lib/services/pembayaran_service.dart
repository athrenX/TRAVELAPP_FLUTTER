import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:travelapp/models/pembayaran.dart';

class PembayaranService {
  final baseUrl = 'https://yourapi.com/api/pembayaran';

  Future<List<Pembayaran>> fetchPembayaranByPemesanan(int pemesananId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/pemesanan/$pemesananId'),
    );
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => Pembayaran.fromJson(e)).toList();
    } else {
      throw Exception('Gagal memuat data pembayaran');
    }
  }

  Future<void> buatPembayaran(Pembayaran pembayaran) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(pembayaran.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Gagal membuat pembayaran');
    }
  }
}
