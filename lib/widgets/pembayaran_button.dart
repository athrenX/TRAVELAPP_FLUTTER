import 'package:flutter/material.dart';

class PembayaranButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final bool isProcessing;

  const PembayaranButton({
    required this.onPressed,
    this.label = 'Bayar Sekarang',
    this.isProcessing = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: isProcessing ? null : onPressed,
      icon:
          isProcessing
              ? SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
              : Icon(Icons.payment),
      label: Text(isProcessing ? 'Memproses...' : label),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
