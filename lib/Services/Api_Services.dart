import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ApiService {
  // Method to perform a GET request
  Future<Map<String, dynamic>?> getData(
      String apiUrl, Map<String, String> headers) async {
    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headers);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load data');
    }
  }

  // Method to perform a POST request
  Future<Map<String, dynamic>?> postData(
      String postUrl, Map<String, String> headers, Object? body) async {
    try {
      final response = await http.post(
        Uri.parse(postUrl),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print(response.toString());
        throw Exception('Failed to load data: ${response.statusCode}');
      }
      log('Response status code: ${response.statusCode}');
      log('Response body: ${response.body}');
    } catch (e) {
      print(e.toString());
      throw Exception('Error: $e');
    }
  }
}
