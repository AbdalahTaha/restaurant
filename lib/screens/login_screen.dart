import 'package:flutter/material.dart';
import './home_page_screen.dart';
import '../services/authenticate.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool showPassword = false;
  String _email = "";
  String _password = "";
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.30),
          child: ProgressHUD(
            child: Builder(builder: (context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                    onChanged: (value) {
                      _email = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    onChanged: (value) {
                      _password = value;
                    },
                    obscureText: showPassword ? false : true,
                    decoration: InputDecoration(
                      hintText: 'Enter your password.',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      errorText: errorText,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CheckboxListTile(
                      value: showPassword,
                      title: Text("show password"),
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (value) {
                        setState(() {
                          showPassword = value ?? false;
                        });
                      }),
                  SizedBox(
                    height: 24.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        final progress = ProgressHUD.of(context);
                        progress?.show();
                        try {
                          await Authenticate.sendCredentials(_email, _password);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return ProductsOverviewScreen();
                          }));
                        } catch (e) {
                          setState(() => errorText = e.toString());
                        }
                        progress?.dismiss();
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(200.0, 42.0),
                          elevation: 5.0,
                          primary: Colors.lightBlue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0))),
                      // minWidth: 200.0,
                      // height: 42.0,
                      child: Text(
                        'Log In',
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
