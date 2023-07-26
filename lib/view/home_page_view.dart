import 'dart:developer';

import 'package:flutter/material.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  late TextEditingController pesoController;
  late TextEditingController alturaController;

  @override
  void initState() {
    pesoController = TextEditingController();
    alturaController = TextEditingController();

    super.initState();
  }

  calculate(double peso, double altura, BuildContext context) {
    if (peso > 0 && altura > 0) {
      double imc = peso / (altura * altura);
      inspect(imc);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('O seu IMC e $imc')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora IMC'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: pesoController,
              decoration: const InputDecoration(
                  labelText: 'Peso em KG',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: alturaController,
              decoration: const InputDecoration(
                  labelText: 'Altura em CM, obs: com ponto apos o metro.',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
            ),
          ),
          FilledButton(
              onPressed: () => calculate(double.parse(pesoController.text),
                  double.parse(alturaController.text), context),
              child: const Text('Calcular'))
        ],
      )),
    );
  }
}
