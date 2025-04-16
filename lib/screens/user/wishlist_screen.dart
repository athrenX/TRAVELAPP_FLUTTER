import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelapp/models/destinasi.dart';
import 'package:travelapp/providers/destinasi_provider.dart';
import 'package:travelapp/providers/wishlist_provider.dart';
import 'package:travelapp/widgets/destinasi_card.dart';

class WishlistScreen extends StatelessWidget {
  final String userId;

  const WishlistScreen({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final destinasiProvider = Provider.of<DestinasiProvider>(context);

    final userWishlists = wishlistProvider.getWishlistsByUser(userId);
    final wishlistDestinasi =
        destinasiProvider.destinasiList.where((destinasi) {
          return userWishlists.any(
            (wishlist) => wishlist.destinasiId == destinasi.id,
          );
        }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist Saya'),
        backgroundColor: Colors.blue.shade800,
      ),
      body:
          wishlistDestinasi.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'Wishlist Anda Kosong',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Tambahkan destinasi favorit Anda',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              )
              : ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: wishlistDestinasi.length,
                itemBuilder: (ctx, index) {
                  final destinasi = wishlistDestinasi[index];
                  return Column(
                    children: [
                      DestinasiCard(
                        destinasi: destinasi,
                        isInWishlist: true,
                        onWishlistChanged: () {
                          wishlistProvider.removeFromWishlist(destinasi.id);
                          ScaffoldMessenger.of(ctx).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${destinasi.nama} dihapus dari wishlist',
                              ),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 16),
                    ],
                  );
                },
              ),
    );
  }
}
