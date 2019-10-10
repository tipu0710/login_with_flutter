import 'package:flutter/material.dart';
import 'package:login_with_flutter/UI/WelcomePageUi.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}
