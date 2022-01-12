import 'package:http/http.dart' as http;
import "dart:convert";
import 'package:shared_preferences/shared_preferences.dart';

class Authenticate {
  static String accessToken = "";
  static Future<void> sendCredentials(String userName, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final body = jsonEncode(
      {
        "grant_type": "password",
        "client_id": prefs.getInt('cashierId'),
        "client_secret": prefs.getString('cashierSecret'),
        "username": userName,
        "password": password,
        "branch_id": 31,
      },
    );
    http.Response response = await http.post(
      Uri.parse("${prefs.getString('domain')}/auth/token"),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: body,
    );
    if (response.statusCode != 200) {
      throw jsonDecode(response.body)['message'];
    }
    accessToken = jsonDecode(response.body)['access_token'];
  }
}
