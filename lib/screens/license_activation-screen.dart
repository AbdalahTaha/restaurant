import 'package:flutter/material.dart';
import '../services/send_activation_license.dart';
import './login_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class ActivationScreen extends StatefulWidget {
  @override
  _ActivationScreenState createState() => _ActivationScreenState();
}

class _ActivationScreenState extends State<ActivationScreen> {
  String _license = "";
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant"),
      ),
      body: ProgressHUD(
        child: Builder(builder: (context) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "License Activation",
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  constraints: BoxConstraints(maxWidth: 400),
                  child: TextField(
                    onChanged: (value) {
                      _license = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter License',
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
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      final progress = ProgressHUD.of(context);
                      progress?.show();
                      int licenseResponseStatusCode =
                          await Licensing().send(_license);
                      progress?.dismiss();
                      if (licenseResponseStatusCode == 200) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => LogInScreen()));
                      } else {
                        Alert(
                          context: context,
                          type: AlertType.error,
                          title: "Error",
                          desc: "Wrong License",
                          buttons: [
                            DialogButton(
                              child: Text(
                                "Close",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () => Navigator.pop(context),
                              width: 120,
                              color: Colors.blue,
                            )
                          ],
                        ).show();
                      }
                    },
                    child: Text('Activate'),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
