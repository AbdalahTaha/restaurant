import 'package:http/http.dart' as http;
import "dart:convert";
import 'package:shared_preferences/shared_preferences.dart';

class Licensing {
  Future<int> send(String license) async {
    http.Response response = await http.post(
      Uri.parse("https://pos-app.com/public/desktop/activation"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {"type": 1, "license": license},
      ),
    );
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('licensed', true);
      prefs.setString('domain', jsonDecode(response.body)["domain"]);
      prefs.setInt(
          'cashierId', jsonDecode(response.body)["cashier"]["client_id"]);
      prefs.setString('cashierSecret',
          jsonDecode(response.body)["cashier"]["client_secret"]);
      prefs.setInt(
          'managerId', jsonDecode(response.body)["manager"]["client_id"]);
      prefs.setString('managerSecret',
          jsonDecode(response.body)["manager"]["client_secret"]);
    }
    return response.statusCode;
  }
}
