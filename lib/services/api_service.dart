import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static const String baseUrl = 'http://myshop1234.atwebpages.com/myapi';
  static final http.Client _client = http.Client();

  static Future<List<Product>> fetchProducts({Duration timeout = const Duration(seconds: 10)}) async {
    final uri = Uri.parse('$baseUrl/getProducts.php');

    try {
      final response = await _client.get(uri).timeout(timeout);

      _checkStatusCode(response);

      final decoded = json.decode(response.body);

      if (decoded is List) {
        return decoded
            .map((e) => Product.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList();
      }

      if (decoded is Map && decoded['products'] is List) {
        return (decoded['products'] as List)
            .map((e) => Product.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList();
      }

      throw Exception('Unexpected JSON structure when fetching products.');
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

 static Future<Product> fetchProductById(int id, {Duration timeout = const Duration(seconds: 10)}) async {
    final uri = Uri.parse('$baseUrl/getProduct.php?id=$id');

    try {
      final response = await _client.get(uri).timeout(timeout);
      _checkStatusCode(response);

      final decoded = json.decode(response.body);

      if (decoded is Map) {
        return Product.fromJson(Map<String, dynamic>.from(decoded));
      }

      throw Exception('Unexpected JSON structure when fetching product.');
    } catch (e) {
      throw Exception('Failed to fetch product: $e');
    }
  }

  static Future<bool> login(String email, String password,
      {Duration timeout = const Duration(seconds: 10)}) async {
    final uri = Uri.parse('$baseUrl/login.php');

    try {
      final response = await _client
          .post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      )
          .timeout(timeout);

      _checkStatusCode(response);

      final decoded = json.decode(response.body);
      if (decoded is Map && decoded['success'] == true) {
        return true;
      }
      return false;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }





  static Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    Duration timeout = const Duration(seconds: 10),
  }) async {
    final uri = Uri.parse('$baseUrl/register.php');

    try {
      final response = await _client
          .post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      )
          .timeout(timeout);

      _checkStatusCode(response);

      final decoded = json.decode(response.body);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
      throw Exception('Unexpected response from server during registration.');
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  static void _checkStatusCode(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Server error: ${response.statusCode} — ${response.body}');
    }
  }

  static void dispose() {
    _client.close();
  }
}
