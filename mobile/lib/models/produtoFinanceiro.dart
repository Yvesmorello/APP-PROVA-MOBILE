import 'categoriaProduto.dart';

class ProdutoFinanceiro {
  String? id;
  String nome;
  String tipo;
  double precoAtual;
  double variacao;
  CategoriaProduto categoria;

  ProdutoFinanceiro({
    required this.nome,
    required this.tipo,
    required this.precoAtual,
    required this.variacao,
    required this.categoria,
  });

  factory ProdutoFinanceiro.fromJson(Map<String, dynamic> json) {
    return ProdutoFinanceiro(
      nome: json['nome'],
      tipo: json['tipo'],
      precoAtual: json['precoAtual'],
      variacao: json['variacao'],
      categoria: CategoriaProduto.fromJson(json['categoria']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'precoAtual': precoAtual,
      'variacao': variacao,
      'categoria': categoria.toJson(),
    };
}
}
