import 'package:flutter/material.dart';
import 'package:flutter_course_recipes/model/receita.dart';

class AdicionarPage extends StatefulWidget {
  @override
  _AdicionarPageState createState() => _AdicionarPageState();
}

class _AdicionarPageState extends State<AdicionarPage> {
  final _nomeController = TextEditingController();
  final _detalhesController = TextEditingController();
  final _imagemController = TextEditingController();
  final _receitaController = TextEditingController();

  final _nomeFocus = FocusNode();
  final _detalhesFocus = FocusNode();
  final _imagemFocus = FocusNode();
  final _receitaFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  Function _salvar;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () => _focus(_nomeFocus));

    Future.delayed(Duration.zero, _loadArguments);
  }

  void _loadArguments() {
    Map args = ModalRoute.of(context).settings.arguments;

    setState(() {
      _salvar = args["salvar"];
    });
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
            padding:
                const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
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
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Ingredientes e preparo *",
                        helperText: " ",
                      ),
                      validator: (String valor) {
                        if (valor.isEmpty) {
                          return "Informe a receita";
                        }

                        if (valor.length < 20) {
                          return "Receita muito curta";
                        }

                        return null;
                      },
                      maxLines: null,
                      minLines: 6,
                      focusNode: _receitaFocus,
                      controller: _receitaController,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                    ),
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

  void _salvarReceita() {
    //Se for válido, permite salvar...
    if (_formKey.currentState.validate()) {
      final receita = Receita(
        nome: _nomeController.text,
        detalhes: _detalhesController.text,
        imagemURL: _imagemController.text,
        receita: _receitaController.text,
      );

      _salvar(receita);
      Navigator.pop(context);
    }
  }

  void _focus(FocusNode node) {
    FocusScope.of(context).requestFocus(node);
  }
}
