import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_course_recipes/model/receita.dart';
import 'package:flutter_course_recipes/service/receita_service.dart';
import 'package:rxdart/subjects.dart';

class ReceitasBloc extends BlocBase {
  List<Receita> _receitas = List();
  final _receitaService = ReceitaService();
  final _receitasController = BehaviorSubject<List<Receita>>();

  Stream<List<Receita>> receitasStream() {
    return _receitasController.stream;
  }

  Future<void> carregarReceitas() async {
    try {
      final receitas = await _receitaService.carregar();

      _receitas = receitas;
      _receitasController.sink.add(_receitas);
    } catch (e) {
      print("ERROR: ${e.toString()}");

      _receitas = List();
      _receitasController.sink.add(_receitas);
    }
  }

  void addReceita(Receita receita) {
    _receitas.add(receita);
    _receitaService.salvar(_receitas);

    _receitasController.sink.add(_receitas);
  }

  void deleteReceita(Receita receita) {
    _receitas.remove(receita);
    _receitaService.salvar(_receitas);

    _receitasController.sink.add(_receitas);
  }

  @override
  void dispose() {
    super.dispose();

    _receitasController.close();
  }
}
