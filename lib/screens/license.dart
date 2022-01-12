import 'package:flutter/material.dart';
import 'package:restaurant_test/screens/license_activation-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './login_screen.dart';

class Licence extends StatefulWidget {
  @override
  _LicenceState createState() => _LicenceState();
}

class _LicenceState extends State<Licence> {
  Future getLicense() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('licensed') == null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => ActivationScreen()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => LogInScreen()));
    }
  }

  @override
  void initState() {
    getLicense();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
