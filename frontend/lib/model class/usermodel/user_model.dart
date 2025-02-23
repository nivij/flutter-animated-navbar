import 'dart:convert';

class User {
  final int id;
  final String googleId;
  final String email;
  final String name;
  final String? profilePic; // Nullable field

  User({
    required this.id,
    required this.googleId,
    required this.email,
    required this.name,
    this.profilePic,
  });

  // Convert JSON to User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      googleId: json['google_id'],
      email: json['email'],
      name: json['name'],
      profilePic: json['profile_picture'], // Make sure field names match FastAPI response
    );
  }

  // Convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "google_id": googleId,
      "email": email,
      "name": name,
      "profile_picture": profilePic,
    };
  }
}
