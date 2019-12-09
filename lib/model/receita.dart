import 'etapa_preparacao.dart';
import 'ingrediente.dart';

class Receita {
  int id;
  String nome;
  String detalhes;
  String imagemURL;
  List<Ingrediente> ingredientes;
  List<EtapaPreparacao> preparo;

  Receita({
    this.id,
    this.nome: "",
    this.detalhes: "",
    this.imagemURL: "",
    this.ingredientes,
    this.preparo,
  }) {
    if (this.id == null) {
      this.id = DateTime.now().millisecondsSinceEpoch;
    }

    if (this.ingredientes == null) {
      this.ingredientes = List();
    }

    if (this.preparo == null) {
      this.preparo = List();
    }
  }

  String getListaIngredientes() {
    String lista = "";

    ingredientes.forEach((ingrediente) {
      lista += ingrediente.nome + "\n";
    });

    return lista;
  }

  String getListaPreparo() {
    String lista = "";

    preparo.forEach((preparo) {
      lista += preparo.descricao + "\n";
    });

    return lista;
  }

  Receita.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    detalhes = json['detalhes'];
    imagemURL = json['imagemURL'];

    final ings = List<Map<String, dynamic>>.from(json['ingredientes']);
    ingredientes = ings.map((ingrediente) {
      return Ingrediente.fromJson(ingrediente);
    }).toList();

    final prep = List<Map<String, dynamic>>.from(json['preparo']);
    preparo = prep.map((etapa) {
      return EtapaPreparacao.fromJson(etapa);
    }).toList();
  }

  Map<String, dynamic> toJson() {
    final data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['nome'] = this.nome;
    data['detalhes'] = this.detalhes;
    data['imagemURL'] = this.imagemURL;

    final ing = this.ingredientes.map((ing) => ing.toJson()).toList();
    data['ingredientes'] = ing;

    final prep = this.preparo.map((pre) => pre.toJson()).toList();
    data['preparo'] = prep;

    return data;
  }
}
