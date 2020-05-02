import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course_recipes/blocs/receitas_bloc.dart';
import 'package:flutter_course_recipes/model/receita.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _loading = true;
  final _bloc = BlocProvider.getBloc<ReceitasBloc>();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, _carregarReceitas);
  }

  void _carregarReceitas() async {
    await _bloc.carregarReceitas();

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas receitas"),
      ),
      body: StreamBuilder<List<Receita>>(
        stream: _bloc.receitasStream(),
        builder: (context, snapshot) {
          if (this._loading) {
            return CircularProgressIndicator();
          }

          if (!snapshot.hasData || snapshot.data.isEmpty) {
            return Center(
              child: Text(
                "Nenhuma receita cadastrada",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.display1,
              ),
            );
          }

          return Container(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                vertical: 32.0,
                horizontal: 16.0,
              ),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                Receita receita = snapshot.data[index];
                return _buildReceita(receita);
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _criarReceita,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildReceita(Receita receita) {
    return ListTile(
      key: Key(receita.id.toString()),
      title: Text(
        receita.nome,
        style: Theme.of(context).textTheme.title,
      ),
      subtitle: Text(receita.detalhes),
      isThreeLine: true,
      onTap: () {
        Navigator.of(context).pushNamed(
          "detalhes",
          arguments: receita,
        );
      },
    );
  }

  void _criarReceita() {
    Navigator.of(context).pushNamed("adicionar");
  }
}
