class Receita {
  int id;
  String nome;
  String detalhes;
  String imagemURL;
  String receita;

  Receita({
    this.nome: "",
    this.detalhes: "",
    this.imagemURL: "",
    this.receita: "",
  }) {
    this.id = DateTime.now().millisecondsSinceEpoch;
  }
}
