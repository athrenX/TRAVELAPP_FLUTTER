import 'package:flutter/material.dart';
import 'package:travelapp/models/review.dart';
import 'package:travelapp/services/review_service.dart';

class ReviewScreen extends StatefulWidget {
  final int destinasiId;
  const ReviewScreen({required this.destinasiId});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final _reviewService = ReviewService();
  List<Review> _reviews = [];

  @override
  void initState() {
    super.initState();
    loadReviews();
  }

  void loadReviews() async {
    final reviews = await _reviewService.fetchReviews(widget.destinasiId);
    setState(() => _reviews = reviews);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ulasan')),
      body: ListView.builder(
        itemCount: _reviews.length,
        itemBuilder: (context, index) {
          final r = _reviews[index];
          return ListTile(
            title: Text('${r.komentar}'),
            subtitle: Text('Rating: ${r.rating}'),
          );
        },
      ),
    );
  }
}
