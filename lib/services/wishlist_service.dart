import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:travelapp/models/wishlist.dart';

class WishlistService {
  final baseUrl = 'https://yourapi.com/api/wishlist';

  Future<List<Wishlist>> fetchWishlist(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/user/$userId'));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => Wishlist.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load wishlist');
    }
  }

  Future<void> addToWishlist(int userId, int destinasiId) async {
    await http.post(
      Uri.parse(baseUrl),
      body: {
        'user_id': userId.toString(),
        'destinasi_id': destinasiId.toString(),
      },
    );
  }
}
