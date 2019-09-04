import 'package:flutter/material.dart';
import 'models/pessoa.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _keyForm = GlobalKey<FormState>();

  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();

  int groupValue;
  Pessoa pessoa = Pessoa();

  void mudarRadio(int valor) {
    setState(() {
      if (valor == 1) {
        groupValue = 1;
      } else if (valor == 2) {
        groupValue = 2;
      }
    });
  }

  void calcularIMC() {
    double weight = double.parse(_weightController.text);
    double height = double.parse(_heightController.text) / 100.0;
    pessoa.calculateImc(weight, height, groupValue);

    setState(() {
      pessoa.result = pessoa.result;
      pessoa.cor = pessoa.cor;
      pessoa.imc = pessoa.imc;
    });
  }

  void _resetFields() {
    _heightController.clear();
    _weightController.clear();
    setState(() {
      pessoa.imc = "--";
      pessoa.result = "Informe os dados";
      pessoa.cor = Colors.black;
      groupValue = 1;
    });
  }

  @override
  void initState() {
    super.initState();
    _resetFields();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Calculadora de IMC"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _resetFields();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: buildContainer(),
      ),
    );
  }

  Widget buildContainer() {
    return Form(
      key: _keyForm,
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildTextFormField(
                label: "Peso (Kg)",
                error: "Digite um peso em quilograma",
                controller: _weightController),
            buildTextFormField(
                label: "Altura (Cm)",
                error: "Digite uma altura em centimetros",
                controller: _heightController),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Radio(
                  onChanged: (int valor) => mudarRadio(valor),
                  activeColor: Colors.blue,
                  value: 1,
                  groupValue: groupValue,
                ),
                GestureDetector(
                  onTap: () {
                    mudarRadio(1);
                  },
                  child: Text("Masculino"),
                ),
                Radio(
                  onChanged: (int valor) => mudarRadio(valor),
                  activeColor: Colors.pink,
                  value: 2,
                  groupValue: groupValue,
                ),
                GestureDetector(
                  onTap: () {
                    mudarRadio(2);
                  },
                  child: Text("Feminino"),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Center(
                child: Text(pessoa.imc,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Center(
                child: Text(pessoa.result,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: pessoa.cor,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: RaisedButton(
                onPressed: () {
                  if (_keyForm.currentState.validate()) {
                    calcularIMC();
                  }
                },
                color: Colors.deepPurple[600],
                child: Text("Calcular"),
                textColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTextFormField(
      {String label, String error, TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: 18, color: Colors.black),
        ),
        validator: (text) {
          return text.isEmpty ? error : null;
        },
      ),
    );
  }
}
