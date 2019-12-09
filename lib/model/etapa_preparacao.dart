class EtapaPreparacao {
  int id;
  String descricao;

  EtapaPreparacao({
    this.descricao: "",
  }) {
    this.id = DateTime.now().millisecondsSinceEpoch;
  }

  EtapaPreparacao.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
  }

  Map<String, dynamic> toJson() {
    final data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['descricao'] = this.descricao;

    return data;
  }
}
