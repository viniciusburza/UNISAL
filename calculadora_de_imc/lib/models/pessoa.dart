import 'package:flutter/material.dart';

class Pessoa {
  double height, weight, bmi;
  String result = "", imc = "";
  Color cor;

  void calculateImc(double weight, double height, int groupValue) {
    double bmi = weight / (height * height);

    imc = "IMC = ${bmi.toStringAsFixed(2)}";

    if (groupValue == 1) {
      if (bmi < 20.7) {
        result = "Abaixo do peso";
        cor = Colors.blue;
      } else if (bmi < 26.4) {
        result = "Peso ideal";
        cor = Colors.green;
      } else if (bmi < 27.8) {
        result = "Pouco acima do peso";
        cor = Colors.yellow;
      } else if (bmi < 31.1) {
        result = "Acima do peso";
        cor = Colors.orange;
      } else {
        result = "Obesidade";
        cor = Colors.red;
      }
    } else if (groupValue == 2) {
      if (bmi < 19.1) {
        result = "Abaixo do peso";
        cor = Colors.blue;
      } else if (bmi < 25.8) {
        result = "Peso ideal";
        cor = Colors.green;
      } else if (bmi < 27.3) {
        result = "Pouco acima do peso";
        cor = Colors.yellow;
      } else if (bmi < 32.3) {
        result = "Acima do peso";
        cor = Colors.orange;
      } else {
        result = "Obesidade";
        cor = Colors.red;
      }
    }
  }
}
