import 'package:flutter/material.dart';

class WishlistIcon extends StatelessWidget {
  final bool isWished;
  final VoidCallback onToggle;

  const WishlistIcon({required this.isWished, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isWished ? Icons.favorite : Icons.favorite_border,
        color: isWished ? Colors.red : Colors.grey,
      ),
      onPressed: onToggle,
    );
  }
}
