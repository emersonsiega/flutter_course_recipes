class Receita {
  int id;
  String nome;
  String detalhes;
  String imagemURL;
  String receita;

  Receita({
    this.id,
    this.nome: "",
    this.detalhes: "",
    this.imagemURL: "",
    this.receita: "",
  }) {
    if (this.id == null) {
      this.id = DateTime.now().millisecondsSinceEpoch;
    }
  }

  Receita.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    detalhes = json['detalhes'];
    imagemURL = json['imagemURL'];
    receita = json['receita'];
  }

  Map<String, dynamic> toJson() {
    final data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['nome'] = this.nome;
    data['detalhes'] = this.detalhes;
    data['imagemURL'] = this.imagemURL;
    data['receita'] = this.receita;

    return data;
  }
}
