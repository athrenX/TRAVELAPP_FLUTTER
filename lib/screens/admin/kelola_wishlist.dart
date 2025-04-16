import 'package:flutter/material.dart';
import 'package:travelapp/services/wishlist_service.dart';
import 'package:travelapp/models/wishlist.dart';

class KelolaWishlist extends StatefulWidget {
  @override
  State<KelolaWishlist> createState() => _KelolaWishlistState();
}

class _KelolaWishlistState extends State<KelolaWishlist> {
  final _service = WishlistService();
  List<Wishlist> _list = [];

  @override
  void initState() {
    super.initState();
    fetchAllWishlist();
  }

  void fetchAllWishlist() async {
    final response = await _service.fetchWishlist(0); // 0 = semua user
    setState(() => _list = response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kelola Wishlist')),
      body: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, index) {
          final w = _list[index];
          return Card(
            child: ListTile(
              title: Text(
                'User ID: ${w.userId} - Destinasi ID: ${w.destinasiId}',
              ),
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
