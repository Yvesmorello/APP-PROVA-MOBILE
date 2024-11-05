import 'package:flutter/material.dart';
import './models/produtoFinanceiro.dart';
import './formularioProdutos.dart';
import './service/produtos_api.dart';

class ListaProdutos extends StatelessWidget {
  final List<ProdutoFinanceiro> produtos;
  final ProdutosApi service = ProdutosApi(); 

  ListaProdutos({super.key, required this.produtos});

  Color getBackgroundColor(String tipo) {
    switch (tipo) {
      case 'Ação':
        return Colors.blue[50]!;
      case 'FII':
        return Colors.amber[50]!;
      default:
        return Colors.grey[50]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Produtos Financeiros')),
      body: ListView.builder(
        itemCount: produtos.length,
        itemBuilder: (context, index) {
          final produto = produtos[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: getBackgroundColor(produto.categoria.nome),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
                border: Border.all(color: Colors.blueAccent, width: 1),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                title: Text(
                  produto.nome,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Preço: R\$${produto.precoAtual.toStringAsFixed(2)} | Variação: ${produto.variacao}%',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      produto.categoria.nome,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FormularioProduto(
                              onAddProduto: (updatedProduto) {
                                //service.updateProduto(produto.id, updatedProduto);
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Excluir Produto'),
                            content: const Text('Você tem certeza que deseja excluir este produto?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(false),
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(true),
                                child: const Text('Excluir'),
                              ),
                            ],
                          ),
                        );
                        if (confirm == true) {
                         //await service.deleteProduto(id);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
