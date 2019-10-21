import 'package:flutter/material.dart';

class DetalhesPage extends StatelessWidget {
  final String nome;

  DetalhesPage({this.nome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nome),
      ),
    );
  }
}
