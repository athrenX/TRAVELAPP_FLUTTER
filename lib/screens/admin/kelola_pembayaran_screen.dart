import 'package:flutter/material.dart';
import 'package:travelapp/services/pembayaran_service.dart';
import 'package:travelapp/models/pembayaran.dart';

class KelolaPembayaran extends StatefulWidget {
  @override
  State<KelolaPembayaran> createState() => _KelolaPembayaranState();
}

class _KelolaPembayaranState extends State<KelolaPembayaran> {
  final _service = PembayaranService();
  List<Pembayaran> _list = [];

  @override
  void initState() {
    super.initState();
    fetchAllPembayaran();
  }

  void fetchAllPembayaran() async {
    // Asumsikan endpoint untuk semua pembayaran
    final response = await _service.fetchPembayaranByPemesanan(
      0,
    ); // 0 = all pemesanan
    setState(() => _list = response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kelola Pembayaran')),
      body: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, index) {
          final p = _list[index];
          return Card(
            child: ListTile(
              title: Text('Pemesanan ID: ${p.pemesananId}'),
              subtitle: Text(
                'Metode: ${p.metode}\nStatus: ${p.status ? 'Lunas' : 'Belum'}',
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
