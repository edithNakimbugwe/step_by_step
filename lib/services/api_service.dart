import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://uetcl.dev/balance_inq_api/api.php';

  static Future<List<dynamic>> getData(String table) async {
    final response = await http.get(Uri.parse('$baseUrl?table=$table'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(
          'Failed to load data: ${response.statusCode} ${response.reasonPhrase}');
      throw Exception(
          'Failed to load data: ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  static Future<void> sendData(String table, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl?table=$table'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
    );
    if (response.statusCode != 200) {
      print(
          'Failed to send data: ${response.statusCode} ${response.reasonPhrase}');
      throw Exception(
          'Failed to send data: ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  static Future<void> updateData(
      String table, int id, Map<String, dynamic> data) async {
    final uri = Uri.parse('$baseUrl?table=$table&id=$id');
    final response = await http.put(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
    );
    if (response.statusCode != 200) {
      print(
          'Failed to update data: ${response.statusCode} ${response.reasonPhrase}');
      throw Exception(
          'Failed to update data: ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  static Future<void> deleteData(String table, int id) async {
    final uri = Uri.parse('$baseUrl?table=$table');
    final response = await http.delete(
      uri,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: 'id=$id',
    );
    if (response.statusCode != 200) {
      print(
          'Failed to delete data: ${response.statusCode} ${response.reasonPhrase}');
      throw Exception(
          'Failed to delete data: ${response.statusCode} ${response.reasonPhrase}');
    }
  }
}
