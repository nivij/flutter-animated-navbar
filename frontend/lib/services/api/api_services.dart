import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model class/usermodel/user_model.dart';

class ApiService {
  static const String baseUrl = "http://192.168.1.5:8000"; // Your FastAPI server URL

  // Fetch Users from FastAPI
  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse("$baseUrl/users/"));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception("Failed to load users");
    }
  }
}
