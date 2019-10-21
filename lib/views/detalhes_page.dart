import 'package:flutter/material.dart';
import 'package:flutter_course_recipes/model/receita.dart';

class DetalhesPage extends StatefulWidget {
  @override
  _DetalhesPageState createState() => _DetalhesPageState();
}

class _DetalhesPageState extends State<DetalhesPage> {
  Receita _receita;
  Function _delete;

  final _nomeController = TextEditingController();
  final _detalhesController = TextEditingController();
  final _receitaController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, _loadArguments);
  }

  void _loadArguments() {
    Map args = ModalRoute.of(context).settings.arguments;

    setState(() {
      _receita = args["receita"];
      _delete = args["delete"];

      _nomeController.text = _receita.nome;
      _detalhesController.text = _receita.detalhes;
      _receitaController.text = _receita.receita;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_receita != null ? _receita.nome : ""),
        actions: <Widget>[
          IconButton(
            onPressed: _onDelete,
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          if (_receita != null && _receita.imagemURL.isNotEmpty)
            Image.network(
              _receita.imagemURL,
              fit: BoxFit.contain,
            ),
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Nome *",
                    helperText: " ",
                  ),
                  controller: _nomeController,
                  readOnly: true,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Detalhes",
                      helperText: " ",
                    ),
                    maxLines: 3,
                    controller: _detalhesController,
                    readOnly: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Ingredientes e preparo *",
                      helperText: " ",
                    ),
                    maxLines: null,
                    controller: _receitaController,
                    readOnly: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onDelete() {
    _delete(_receita);
    Navigator.of(context).pop();
  }
}
