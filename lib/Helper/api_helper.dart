import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static fetchQuotes() async {
    final response = await http.get(
      Uri.parse('https://api.quotable.io/random'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception("Failed to Load");
    }
  }
}
