class Pemesanan {
  final String id;
  final String userId;
  final String destinasiId;
  final String kendaraanId;
  final int jumlahPeserta;
  final DateTime tanggal;
  final double totalHarga;

  Pemesanan({
    required this.id,
    required this.userId,
    required this.destinasiId,
    required this.kendaraanId,
    required this.jumlahPeserta,
    required this.tanggal,
    required this.totalHarga,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'user_id': userId,
    'destinasiId': destinasiId,
    'kendaraanIid': kendaraanId,
    'jumlah_peserta': jumlahPeserta,
    'tanggal': tanggal.toIso8601String(),
    'total_harga': totalHarga,
  };

  factory Pemesanan.fromJson(Map<String, dynamic> json) {
    return Pemesanan(
      id: json['id'],
      userId: json['user_id'],
      destinasiId: json['destinasi_id'],
      kendaraanId: json['kendaraan_id'],
      jumlahPeserta: json['jumlah_peserta'],
      tanggal: DateTime.parse(json['tanggal']),
      totalHarga: json['total_harga'],
    );
  }
}
