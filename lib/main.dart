import 'package:flutter/material.dart';
import 'package:flutter_course_recipes/views/adicionar_page.dart';
import 'package:flutter_course_recipes/views/detalhes_page.dart';
import 'package:flutter_course_recipes/views/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Recipes",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff9C62C0),
        accentColor: Color(0xff9C62C0),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      routes: _buildRoutes(),
    );
  }

  _buildRoutes() {
    return {
      "/": (_) => HomePage(),
      "adicionar": (_) => AdicionarPage(),
      "detalhes": (_) => DetalhesPage(),
    };
  }
}
