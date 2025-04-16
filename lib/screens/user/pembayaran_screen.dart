import 'package:flutter/material.dart';
import 'package:travelapp/services/pembayaran_service.dart';
import 'package:travelapp/models/pembayaran.dart';

class PembayaranScreen extends StatefulWidget {
  final int pemesananId;
  const PembayaranScreen({required this.pemesananId});

  @override
  State<PembayaranScreen> createState() => _PembayaranScreenState();
}

class _PembayaranScreenState extends State<PembayaranScreen> {
  final _service = PembayaranService();
  List<Pembayaran> _list = [];

  @override
  void initState() {
    super.initState();
    loadPembayaran();
  }

  void loadPembayaran() async {
    final data = await _service.fetchPembayaranByPemesanan(widget.pemesananId);
    setState(() => _list = data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pembayaran')),
      body: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, index) {
          final p = _list[index];
          return ListTile(
            title: Text('Metode: ${p.metode}'),
            subtitle: Text('Status: ${p.status ? 'Lunas' : 'Belum Lunas'}'),
            trailing: Icon(
              p.status ? Icons.check_circle : Icons.hourglass_bottom,
              color: p.status ? Colors.green : Colors.orange,
            ),
          );
        },
      ),
    );
  }
}
