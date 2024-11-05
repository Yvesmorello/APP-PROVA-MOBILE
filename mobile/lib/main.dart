import 'package:flutter/material.dart';
import './models/produtoFinanceiro.dart';
import './listaProdutos.dart';
import './formularioProdutos.dart';
import './dashBoard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Análise de Produtos',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
      routes: {
        '/listaProdutos': (context) => ListaProdutos(produtos: const []), 
        '/adicionarProduto': (context) => FormularioProduto(onAddProduto: (produto) {}), 
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final List<ProdutoFinanceiro> produtos = [];
  

  void addProduto(ProdutoFinanceiro produto) {
    setState(() {
      produtos.add(produto);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Análise de Produtos')),
      body: DashboardScreen(),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              title: const Text('Lista de Produtos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListaProdutos(produtos: produtos),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Adicionar Produto'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FormularioProduto(
                      onAddProduto: (produto) {
                        addProduto(produto);
                        Navigator.pop(context); 
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListaProdutos(produtos: produtos),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
