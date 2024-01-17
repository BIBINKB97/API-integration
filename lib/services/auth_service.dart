import 'dart:convert';

import 'package:api/api/api_key.dart';
import 'package:api/model/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final client = http.Client();

  Future<UserModel?> login(String username, String password) async {
    final Map<String, dynamic> body = {
      'username': username,
      'password': password,
    };
    try {
      final response =
          await client.post(Uri.parse("${API().baseUrl}${API().authUrl}"),
              headers: {
                'Content-Type': 'application/json',
              },
              body: jsonEncode(body));

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        final UserModel user = UserModel.fromJson(result);
        return user;
      } else {
        print("Request failed with status code ${response.statusCode}");
      }
    } catch (error) {
      print('error');
    }
    return null;
  }
}
