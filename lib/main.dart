import 'package:flutter/material.dart';
import 'package:restaurant_test/screens/license.dart';
import 'package:restaurant_test/providers/cart.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Cart(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Restaurant',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Licence(),
      ),
    );
  }
}
