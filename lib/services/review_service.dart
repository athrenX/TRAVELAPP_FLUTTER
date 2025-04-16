import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:travelapp/models/review.dart';

class ReviewService {
  final baseUrl = 'https://yourapi.com/api/reviews';

  Future<List<Review>> fetchReviews(int destinasiId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/destinasi/$destinasiId'),
    );
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => Review.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load reviews');
    }
  }

  Future<void> submitReview(Review review) async {
    await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(review.toJson()),
    );
  }
}
