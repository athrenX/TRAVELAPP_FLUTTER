import 'package:flutter/material.dart';
import 'package:travelapp/services/review_service.dart';
import 'package:travelapp/models/review.dart';

class KelolaRating extends StatefulWidget {
  @override
  State<KelolaRating> createState() => _KelolaRatingState();
}

class _KelolaRatingState extends State<KelolaRating> {
  final _service = ReviewService();
  List<Review> _list = [];

  @override
  void initState() {
    super.initState();
    fetchAllReview();
  }

  void fetchAllReview() async {
    // Asumsikan ada endpoint untuk semua review
    final response = await _service.fetchReviews(0); // 0 = semua destinasi
    setState(() => _list = response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kelola Rating & Review')),
      body: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, index) {
          final r = _list[index];
          return Card(
            child: ListTile(
              title: Text(
                'Destinasi ID: ${r.destinasiId} - Rating: ${r.rating}',
              ),
              subtitle: Text(r.komentar),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  // Tambahkan delete logic
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
