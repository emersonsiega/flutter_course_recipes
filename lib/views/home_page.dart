import 'package:flutter/material.dart';
import 'package:flutter_course_recipes/model/receita.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Receita> _receitas;

  @override
  void initState() {
    super.initState();

    _receitas = List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas receitas"),
      ),
      body: Container(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
          itemCount: _receitas.length,
          itemBuilder: (context, index) {
            return _buildReceita(index);
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _criarReceita,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildReceita(int index) {
    Receita receita = _receitas[index];

    return ListTile(
      key: Key(receita.id.toString()),
      title: Text(
        receita.nome,
        style: Theme.of(context).textTheme.title,
      ),
      subtitle: Text(receita.detalhes),
      isThreeLine: true,
    );
  }

  void _criarReceita() {
    Navigator.of(context).pushNamed(
      "adicionar",
      arguments: {"salvar": _addReceita},
    );
  }

  void _addReceita(Receita receita) {
    setState(() {
      _receitas.add(receita);
    });
  }
}
