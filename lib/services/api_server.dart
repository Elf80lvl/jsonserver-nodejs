import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jsonserver/const.dart';

class ApiServer {
  static Future<List<dynamic>> fetchUsers() async {
    final response = await http.get(Uri.parse('$kBaseUrl/users'));
    if (response.statusCode == 200) {
      // print(response.body);
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }

  static Future<Map<String, dynamic>> addUser(Map<String, dynamic> user) async {
    final response = await http.post(
      Uri.parse('$kBaseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user),
    );
    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to add user');
    }
  }

  static Future<void> deleteUser(String id) async {
    final response = await http.delete(
      Uri.parse('$kBaseUrl/users/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete user');
    }
  }
}
