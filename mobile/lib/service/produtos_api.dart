import 'package:http/http.dart' as http;
import 'package:mobile/models/produtoFinanceiro.dart';
import 'abstract_api.dart';

class ProdutosApi extends AbstractApi {
  ProdutosApi({http.Client? client})
      : super('produtos', client ?? http.Client()); 

  Future<void> addProduto(ProdutoFinanceiro produto) async {
    await add(produto);
  }

  Future<void> updateProduto(String id, ProdutoFinanceiro produto) async {
    await update(id, produto);
  }

  Future<void> deleteProduto(String id) async {
    await delete(id);
  }
}
