import 'package:flutter/material.dart';
import 'package:travelapp/services/wishlist_service.dart';
import 'package:travelapp/models/wishlist.dart';

class WishlistScreen extends StatefulWidget {
  final int userId;
  const WishlistScreen({required this.userId});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final _service = WishlistService();
  List<Wishlist> _items = [];

  @override
  void initState() {
    super.initState();
    loadWishlist();
  }

  void loadWishlist() async {
    final items = await _service.fetchWishlist(widget.userId);
    setState(() => _items = items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wishlist')),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final w = _items[index];
          return ListTile(title: Text('Destinasi ID: ${w.destinasiId}'));
        },
      ),
    );
  }
}
