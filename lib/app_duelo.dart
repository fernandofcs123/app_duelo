import 'package:app_duelo/modules/duelo/duelo_page.dart';
import 'package:app_duelo/modules/inicial/inicial_page.dart';
import 'package:flutter/material.dart';

class AppDuelo extends StatelessWidget {
  const AppDuelo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Duelo",
      routes: {
        '/':(_)=> InicialPage(),
        '/duelo':(_)=> DueloPage(),
      },
    );
  }
}