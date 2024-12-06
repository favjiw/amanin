class Laporan{
  final int id;
  final int userId;
  final String desc;
  final String image;
  final String latitude;
  final String longitude;
  final String datetime;
  final String status;

  Laporan(
      this.id,
      this.userId,
      this.desc,
      this.image,
      this.latitude,
      this.longitude,
      this.datetime,
      this.status
      );
  factory Laporan.fromMap(Map<String, dynamic> json){
    return Laporan(json['id'], json['user_id'], json['description'], json['image'], json['latitude'], json['longitude'], json['datetime'], json['status']);
  }
  factory Laporan.fromJson(Map<String, dynamic> json){
    return Laporan(json['id'], json['user_id'], json['description'], json['image'], json['latitude'], json['longitude'], json['datetime'], json['status']);
  }
}