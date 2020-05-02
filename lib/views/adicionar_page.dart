import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course_recipes/blocs/receitas_bloc.dart';
import 'package:flutter_course_recipes/model/etapa_preparacao.dart';
import 'package:flutter_course_recipes/model/ingrediente.dart';
import 'package:flutter_course_recipes/model/receita.dart';
import 'package:flutter_course_recipes/views/preparo_tile.dart';

import 'ingrediente_tile.dart';

class AdicionarPage extends StatefulWidget {
  @override
  _AdicionarPageState createState() => _AdicionarPageState();
}

class _AdicionarPageState extends State<AdicionarPage> {
  final _nomeController = TextEditingController();
  final _detalhesController = TextEditingController();
  final _imagemController = TextEditingController();

  final _nomeFocus = FocusNode();
  final _detalhesFocus = FocusNode();
  final _imagemFocus = FocusNode();
  final _receitaFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  List<Ingrediente> _ingredientes = List();
  List<EtapaPreparacao> _preparo = List();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () => _focus(_nomeFocus));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar"),
      ),
      body: GestureDetector(
        onTap: () => _focus(FocusNode()),
        child: Container(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 32, 16, 70),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Nome *",
                      helperText: " ",
                    ),
                    focusNode: _nomeFocus,
                    controller: _nomeController,
                    textInputAction: TextInputAction.next,
                    validator: (String valor) {
                      if (valor.isEmpty) {
                        return "Informe o nome";
                      }

                      if (valor.length < 3) {
                        return "Nome muito curto";
                      }

                      return null;
                    },
                    onEditingComplete: () => _focus(_detalhesFocus),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Detalhes",
                        helperText: " ",
                      ),
                      maxLines: 3,
                      focusNode: _detalhesFocus,
                      controller: _detalhesController,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _focus(_imagemFocus),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Imagem",
                        helperText: "Link da imagem",
                      ),
                      validator: (String value) {
                        Pattern pattern =
                            r"^[(http(s)?):\/\/(www\.)?a-zA-Z0-9-@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)$";

                        RegExp regex = new RegExp(pattern);
                        if (value.isNotEmpty && !regex.hasMatch(value)) {
                          return 'Link inválido';
                        }

                        return null;
                      },
                      focusNode: _imagemFocus,
                      controller: _imagemController,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _focus(_receitaFocus),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text("Ingredientes"),
                      IconButton(
                        icon: Icon(
                          Icons.add_circle,
                          color: Colors.green,
                        ),
                        onPressed: () => _addIngrediente(),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: _ingredientes.map((ingrediente) {
                      return IngredienteTile(
                        key: Key(ingrediente.id.toString()),
                        onChanged: (value) {
                          ingrediente.nome = value;

                          _updateIngrediente(ingrediente);
                        },
                        ingrediente: ingrediente,
                        onRemove: _onRemoveIngrediente,
                      );
                    }).toList(),
                  ),
                  Row(
                    children: <Widget>[
                      Text("Preparação"),
                      IconButton(
                        icon: Icon(
                          Icons.add_circle,
                          color: Colors.green,
                        ),
                        onPressed: () => _addEtapaPreparacao(),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: _preparo.map((preparo) {
                      return PreparoTile(
                        key: Key(preparo.id.toString()),
                        onChanged: (value) {
                          preparo.descricao = value;

                          _updatePreparo(preparo);
                        },
                        preparo: preparo,
                        onRemove: _onRemovePreparo,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _salvarReceita,
        child: Icon(Icons.check),
      ),
    );
  }

  void _addIngrediente() {
    if (_ingredientes.isEmpty || _ingredientes.last.nome.isNotEmpty) {
      setState(() {
        _ingredientes.add(Ingrediente());
      });
    }
  }

  void _onRemoveIngrediente(int id) {
    setState(() {
      _ingredientes.removeWhere((ing) => ing.id == id);
    });
  }

  void _updateIngrediente(Ingrediente ingrediente) {
    setState(() {
      _ingredientes.map((ing) {
        if (ing.id == ingrediente.id) {
          return ingrediente;
        }

        return ing;
      });
    });
  }

  void _addEtapaPreparacao() {
    if (_preparo.isEmpty || _preparo.last.descricao.isNotEmpty) {
      setState(() {
        _preparo.add(EtapaPreparacao());
      });
    }
  }

  void _onRemovePreparo(int id) {
    setState(() {
      _preparo.removeWhere((ing) => ing.id == id);
    });
  }

  void _updatePreparo(EtapaPreparacao etapa) {
    setState(() {
      _preparo.map((e) {
        if (e.id == etapa.id) {
          return etapa;
        }

        return e;
      });
    });
  }

  void _salvarReceita() {
    setState(() {
      _ingredientes.removeWhere((ing) => ing.nome.isEmpty);
      _preparo.removeWhere((prep) => prep.descricao.isEmpty);
    });

    if (_preparo.isEmpty || _ingredientes.isEmpty) {
      return;
    }

    //Se for válido, permite salvar...
    if (_formKey.currentState.validate()) {
      final receita = Receita(
        nome: _nomeController.text,
        detalhes: _detalhesController.text,
        imagemURL: _imagemController.text,
        ingredientes: _ingredientes,
        preparo: _preparo,
      );

      final bloc = BlocProvider.getBloc<ReceitasBloc>();
      bloc.addReceita(receita);

      Navigator.pop(context);
    }
  }

  void _focus(FocusNode node) {
    FocusScope.of(context).requestFocus(node);
  }
}
