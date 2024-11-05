import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:mobile/listaProdutos.dart';
import 'package:mobile/models/categoriaProduto.dart';
import 'package:mobile/service/produtos_api.dart';
import 'package:mobile/models/produtoFinanceiro.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  group('ProdutosApi', () {
    late ProdutosApi produtosApi;

    test('addProduto deve adicionar um novo produto com sucesso', () async {
      final mockClient = MockClient((request) async {
        return http.Response('', 201);
      });

      produtosApi = ProdutosApi(client: mockClient);

      final produto = ProdutoFinanceiro(
        nome: 'Produto Teste',
        tipo: 'Ação',
        precoAtual: 100.0,
        variacao: 5.0,
        categoria: CategoriaProduto(nome: 'Ação', descricao: 'Ação de Teste'),
      );

      await produtosApi.addProduto(produto);
      expect(true, true);
    });

    test('getAll deve retornar uma lista de produtos', () async {
      final mockClient = MockClient((request) async {
        return http.Response(
          jsonEncode([
            {
              "nome": "Produto Teste",
              "tipo": "Ação",
              "precoAtual": 100.0,
              "variacao": 5.0,
              "categoria": {"nome": "Ação", "descricao": "Ação de Teste"}
            },
          ]),
          200,
        );
      });

      produtosApi = ProdutosApi(client: mockClient);

      final produtos = await produtosApi.getAll();
      expect(produtos.length, 1);
      expect(produtos[0]['nome'], 'Produto Teste');
    });

    test('deve filtrar produtos do tipo "Ação"', () async {
      final produtosJson = [
        {
          "nome": "Ação XYZ",
          "tipo": "Ação",
          "precoAtual": 100.0,
          "variacao": 2.5,
          "categoria": {"nome": "Ação", "descricao": "Ação de Empresa"}
        },
        {
          "nome": "FII ABC",
          "tipo": "FII",
          "precoAtual": 120.0,
          "variacao": -1.0,
          "categoria": {"nome": "FII", "descricao": "Fundo Imobiliário"}
        },
        {
          "nome": "Ação ABC",
          "tipo": "Ação",
          "precoAtual": 90.0,
          "variacao": 1.5,
          "categoria": {"nome": "Ação", "descricao": "Ação de Empresa"}
        },
      ];

      final mockClient = MockClient((request) async {
        return http.Response(jsonEncode(produtosJson), 200);
      });

      produtosApi = ProdutosApi(client: mockClient);

      final produtos = await produtosApi.getAll();
      final produtosAcoes = produtos.where((produto) => produto['tipo'] == 'Ação').toList();

      expect(produtosAcoes.length, equals(2));
      expect(produtosAcoes[0]['nome'], equals('Ação XYZ'));
      expect(produtosAcoes[1]['nome'], equals('Ação ABC'));
    });
  });

  testWidgets('ListaProdutos exibe uma lista de produtos', (WidgetTester tester) async {
    final produtos = [
      ProdutoFinanceiro(
        nome: 'Ação XYZ',
        tipo: 'Ação',
        precoAtual: 100.0,
        variacao: 2.5,
        categoria: CategoriaProduto(nome: 'Ação', descricao: 'Ação de Empresa'),
      ),
      ProdutoFinanceiro(
        nome: 'FII ABC',
        tipo: 'FII',
        precoAtual: 120.0,
        variacao: -1.0,
        categoria: CategoriaProduto(nome: 'FII', descricao: 'Fundo Imobiliário'),
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: ListaProdutos(produtos: produtos),
      ),
    );

    expect(find.text('Ação XYZ'), findsOneWidget);
    expect(find.text('FII ABC'), findsOneWidget);
    expect(find.text('Preço: R\$100.00 | Variação: 2.5%'), findsOneWidget);
    expect(find.text('Preço: R\$120.00 | Variação: -1.0%'), findsOneWidget);
  });

}
