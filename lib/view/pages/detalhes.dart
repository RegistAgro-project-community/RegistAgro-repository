import 'package:flutter/material.dart';

class DETALHESPRODUTO extends StatelessWidget {
  final Carro carro;
  const DETALHESPRODUTO({required this.carro, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(carro.modelo)),
      body: Center(child: Text(carro.ano.toString())),
    );
  }
}

class Carro {
  String modelo;
  int ano;

  Carro(this.modelo, this.ano);
}

class Pessoa {
  String nome;
  int idade;

  Pessoa(this.nome, this.idade);
}

var carro1 = Carro('Toyota', 2020);
var carro2 = Carro("Hyundai", 2016);
var pessoa1 = Pessoa('Ana', 25);
