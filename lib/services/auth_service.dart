import 'package:api/api/api_key.dart';
import 'package:api/model/user_model.dart';
import 'package:http/http.dart' as http ;


class AuthService {
  final client = http.Client();


 Future <UserModel> login(String username , String password) async{

try {
  final response = await client.post(
    Uri.parse("${API().baseUrl}${API().authUrl}"),
  );
}
 }


}
