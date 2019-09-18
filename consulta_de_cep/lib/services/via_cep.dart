import 'package:consulta_de_cep/models/result_cep.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViaCep {
  static Future<ResultCep> fetchCep({@required String cep}) async {
    final response = await http.get('https://viacep.com.br/ws/$cep/json/');
    if (response.statusCode == 200) {
      if (resultCepFromJson(response.body).cep == null) {
        throw ('CEP digitado não existe');
      }
      return resultCepFromJson(response.body);
    } else if (response.statusCode == 400) {
      throw ('CEP invalido');
    } else {
      throw Exception('Erro ${response.statusCode}.');
    }
  }
}
