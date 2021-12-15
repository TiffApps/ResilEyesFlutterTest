import 'package:flutter/material.dart';
import 'package:resileyes_flutter_test/pages/home.dart';

void main() {
  runApp(const ResilEyesTest());
}

class ResilEyesTest extends StatelessWidget {
  const ResilEyesTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resil Eyes Flutter Test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Home Page'),
    );
  }
}
