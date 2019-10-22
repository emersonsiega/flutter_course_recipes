import 'dart:convert';

import 'package:flutter_course_recipes/model/receita.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReceitaService {
  Future<List<Receita>> carregar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String data = await prefs.getString('receitas');

    if (data == null) {
      return List();
    }

    final list = List<Map<String, dynamic>>.from(json.decode(data));

    List<Receita> receitas =
        list.map((item) => Receita.fromJson(item)).toList();

    return receitas;
  }

  void salvar(List<Receita> receitas) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<Map<String, dynamic>> map =
        receitas.map((receita) => receita.toJson()).toList();

    await prefs.setString('receitas', json.encode(map));
  }
}
