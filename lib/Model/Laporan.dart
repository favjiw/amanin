class Laporan{
  final int id;
  final int userId;
  final String title;
  final String desc;
  final String image; // Optional karena bisa null
  final String location;
  final String latitude; // Menggunakan double
  final String longitude; // Menggunakan double
  final String datetime;
  final String status;
  final String createdAt;

  Laporan({
    required this.id,
    required this.userId,
    required this.title,
    required this.desc,
    required this.image,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.datetime,
    required this.status,
    required this.createdAt,
  });

  factory Laporan.fromMap(Map<String, dynamic> json) {
    return Laporan(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      title: json['title'] ?? '',
      desc: json['description'] ?? '',
      image: json['image_url'],
      location: json['lokasi_kejadian'] ?? '',
      latitude: json['latitude'],
      longitude: json['longitude'],
      datetime: json['datetime'] ?? '',
      status: json['status'] ?? 'unknown',
      createdAt: json['created_at'] ?? '',
    );
  }

  factory Laporan.fromJson(Map<String, dynamic> json) {
    return Laporan.fromMap(json);
  }
}