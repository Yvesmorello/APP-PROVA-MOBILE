import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile/models/produtoFinanceiro.dart';

abstract class AbstractApi {
  final String urlLocalhost = 'http://localhost:3000';
  final String recurso;
  final http.Client httpClient; 

  AbstractApi(this.recurso, this.httpClient); 
  Future<List<dynamic>> getAll() async {
    var response = await httpClient.get(Uri.parse('$urlLocalhost/$recurso'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Erro ao buscar $recurso");
    }
  }

  Future<void> add(ProdutoFinanceiro item) async {
    var response = await httpClient.post(
      Uri.parse('$urlLocalhost/$recurso'),
      body: jsonEncode(item),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
      print("Item adicionado com sucesso");
    } else {
      throw Exception("Erro ao adicionar item em $recurso");
    }
  }

  Future<void> update(String id, ProdutoFinanceiro item) async {
    var response = await httpClient.put(
      Uri.parse('$urlLocalhost/$recurso/$id'),
      body: jsonEncode(item),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      print("Item atualizado com sucesso");
    } else {
      throw Exception("Erro ao atualizar item em $recurso");
    }
  }

  Future<void> delete(String id) async {
    var response = await httpClient.delete(Uri.parse('$urlLocalhost/$recurso/$id'));
    if (response.statusCode == 200) {
      print("Item excluído com sucesso");
    } else {
      throw Exception("Erro ao excluir item em $recurso");
    }
  }
}
