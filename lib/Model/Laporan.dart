class Laporan{
  final int id;
  final int userId;
  final String title;
  final String desc;
  final String image;
  final String location;
  final String latitude;
  final String longitude;
  final String datetime;
  final String status;
  final String created_at;

  Laporan(
      this.id,
      this.userId,
      this.title,
      this.desc,
      this.image,
      this.location,
      this.latitude,
      this.longitude,
      this.datetime,
      this.status,
      this.created_at
      );
  factory Laporan.fromMap(Map<String, dynamic> json){
    return Laporan(json['id'], json['user_id'], json['title'], json['description'],  json['image'], json['lokasi_kejadian'], json['latitude'], json['longitude'], json['datetime'], json['status'], json['created_at']);
  }
  factory Laporan.fromJson(Map<String, dynamic> json){
    return Laporan(json['id'], json['user_id'], json['title'], json['description'],  json['image'], json['lokasi_kejadian'], json['latitude'], json['longitude'], json['datetime'], json['status'], json['created_at']);
  }
}