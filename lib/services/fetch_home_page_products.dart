import 'dart:convert';
import 'package:http/http.dart' as http;
import './authenticate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/categories.dart';

class FetchProducts {
  static getCategoriesAndPackages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.get(
      Uri.parse('${prefs.getString('domain')}/desktop'),
      headers: {'Authorization': 'Bearer ${Authenticate.accessToken}'},
    );
    Categories.fromJson(jsonDecode(response.body));
  }
}
