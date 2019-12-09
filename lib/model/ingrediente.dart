class Ingrediente {
  int id;
  String nome;

  Ingrediente({
    this.nome: "",
  }) {
    this.id = DateTime.now().millisecondsSinceEpoch;
  }

  Ingrediente.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
  }

  Map<String, dynamic> toJson() {
    final data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['nome'] = this.nome;

    return data;
  }
}
