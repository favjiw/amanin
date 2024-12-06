class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String role;
  final String? emailVerifiedAt;
  final String? createdAt;
  final String? updatedAt;

  User(
      this.id,
      this.name,
      this.username,
      this.email,
      this.role,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt);

  factory User.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      return User(
        json['id'],
        json['name'],
        json['username'],
        json['email'],
        json['role'],
        json['email_verified_at'],
        json['created_at'],
        json['updated_at'],
      );
    } else {
      throw Exception("This is from User Model: Invalid user data: missing or invalid fields");
    }
  }
}