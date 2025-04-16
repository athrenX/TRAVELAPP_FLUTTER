import 'package:flutter/material.dart';
import 'package:travelapp/models/kendaraan.dart';
import 'package:travelapp/models/destinasi.dart';
import 'package:travelapp/models/pemesanan.dart';
import 'package:travelapp/screens/user/pembayaran_screen.dart';
import 'package:travelapp/services/pemesanan_service.dart';

class PemesananScreen extends StatefulWidget {
  final Destinasi destinasi;
  final Kendaraan kendaraan;

  PemesananScreen({required this.destinasi, required this.kendaraan});

  @override
  _PemesananScreenState createState() => _PemesananScreenState();
}

class _PemesananScreenState extends State<PemesananScreen> {
  final _jumlahPesertaController = TextEditingController();
  final _pemesananService = PemesananService();

  late double totalHarga;

  @override
  void initState() {
    super.initState();
    totalHarga = widget.kendaraan.harga;
  }

  void _updateTotalPrice() {
    final jumlahPeserta = int.tryParse(_jumlahPesertaController.text) ?? 0;
    setState(() {
      totalHarga = widget.kendaraan.harga * jumlahPeserta;
    });
  }

  bool _isLoading = false;

  void _prosesPemesanan() async {
    final jumlahPeserta = int.tryParse(_jumlahPesertaController.text);
    if (jumlahPeserta == null || jumlahPeserta <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Jumlah peserta tidak valid")));
      return;
    }

    final pemesanan = Pemesanan(
      id: '',
      userId: 'userId',
      destinasiId: widget.destinasi.id,
      kendaraanId: widget.kendaraan.id,
      jumlahPeserta: jumlahPeserta,
      tanggal: DateTime.now(),
      totalHarga: totalHarga,
    );

    try {
      print('Mengirim data pemesanan: ${pemesanan.toMap()}');
      final createdId = await _pemesananService.createPemesanan(pemesanan);
      print('Pemesanan berhasil dibuat dengan ID: $createdId');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PembayaranScreen(pemesananId: createdId),
        ),
      );
    } catch (e, stack) {
      print("Gagal memproses pemesanan: $e");
      print("Stacktrace: $stack");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal memproses pemesanan: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pemesanan')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Destinasi: ${widget.destinasi.nama}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8),
            Text(
              'Kendaraan: ${widget.kendaraan.jenis}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _jumlahPesertaController,
              decoration: InputDecoration(labelText: 'Jumlah Peserta'),
              keyboardType: TextInputType.number,
              onChanged: (_) => _updateTotalPrice(),
            ),
            SizedBox(height: 16),
            Text('Total Harga: Rp $totalHarga'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _prosesPemesanan,
              child: Text('Lanjut ke Pembayaran'),
            ),
          ],
        ),
      ),
    );
  }
}
