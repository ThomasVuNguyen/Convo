import 'package:convo/confirmation_page.dart';
import 'package:convo/themes/color_scheme.dart';
import 'package:convo/themes/typography.dart';
import 'package:flutter/material.dart';

import 'chatPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: lightColorScheme,
        textTheme: ComfyTextTheme,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        //darkColorScheme,
        textTheme: ComfyTextTheme,
      ),
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.ltr,
        child: chatPage(
          questions: {'name': ['what is your name?'], 'dob': ['how old are you?', 'in mm/dd/yyyy format']},
          answers: {},
          title: 'Convo, a chat app',
        ),
      ),
    );
  }
}


