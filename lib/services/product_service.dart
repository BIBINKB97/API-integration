import 'dart:convert';

import 'package:api/api/api_key.dart';
import 'package:api/model/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductService {
  final client = http.Client();

  Future<ProductModel?> getAllProducts() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    final token = _pref.get('token');
    print(token);

    try {
      final response = await client
          .get(Uri.parse("${API().baseUrl}${API().allProducts}"), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token}',
      });
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final ProductModel product = ProductModel.fromJson(responseBody);
        return product;
      }
    } catch (er) {
    }
  }
}
