import 'package:calculadora_imc/models/pessoa_model.dart';
import 'package:flutter/material.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  late TextEditingController pesoController;
  late TextEditingController alturaController;
  PessoaModel? pessoa;

  @override
  void initState() {
    pesoController = TextEditingController();
    alturaController = TextEditingController();

    super.initState();
  }

  calculate(double peso, double altura, BuildContext context) {
    String information = '';
    if (peso > 0 && altura > 0) {
      final double imc = peso / (altura * altura);

      if (imc < 16) {
        information = 'magreza grave';
      } else if (imc > 16 && imc < 17) {
        information = 'magreza moderada';
      } else if (imc > 17 && imc < 18.5) {
        information = 'magreza leve';
      } else if (imc > 18.5 && imc < 25) {
        information = 'saudavel';
      } else if (imc > 25 && imc < 30) {
        information = 'sobrepeso';
      } else if (imc > 30 && imc < 35) {
        information = 'obesidade grau I';
      } else if (imc > 35 && imc < 40) {
        information = 'obesidade grau II';
      } else if (imc >= 40.1) {
        information = 'saudavel';
      }

      setState(() {});
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(information)));

      return PessoaModel(
          peso: peso.toString(), altura: altura.toString(), imc: imc);
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
              onPressed: () async {
                pessoa = await calculate(double.parse(pesoController.text),
                    double.parse(alturaController.text), context);

                pesoController.clear();
                alturaController.clear();
              },
              child: const Text('Calcular')),
          Expanded(
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              children: [
                Column(
                  children: [
                    const Text('Peso'),
                    pessoa == null ? Container() : Text(pessoa!.peso),
                  ],
                ),
                Column(
                  children: [
                    const Text('Altura'),
                    pessoa == null ? Container() : Text(pessoa!.altura),
                  ],
                ),
                Column(
                  children: [
                    const Text('IMC'),
                    pessoa == null
                        ? Container()
                        : Text(pessoa!.imc.toStringAsFixed(2)),
                  ],
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
