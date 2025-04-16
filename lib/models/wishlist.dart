class Wishlist {
  final int id;
  final int userId;
  final int destinasiId;

  Wishlist({required this.id, required this.userId, required this.destinasiId});

  factory Wishlist.fromJson(Map<String, dynamic> json) {
    return Wishlist(
      id: json['id'],
      userId: json['user_id'],
      destinasiId: json['destinasi_id'],
    );
  }
}
