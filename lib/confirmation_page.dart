import 'package:flutter/material.dart';

class confirmationPage extends StatelessWidget {
  const confirmationPage({super.key, required this.name, required this.dob});
  final String name; final String dob;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Text('Congratulations for finishing the app, $name & $dob}'),
      ),
    );
  }
}
