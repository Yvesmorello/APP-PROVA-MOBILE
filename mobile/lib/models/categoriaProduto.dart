class CategoriaProduto {
  final String nome;
  final String descricao;

  CategoriaProduto({required this.nome, required this.descricao});

  factory CategoriaProduto.fromJson(Map<String, dynamic> json) {
    return CategoriaProduto(
      nome: json['nome'],
      descricao: json['descricao'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'descricao': descricao,
    };
  }
}
