import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:teste_flutter/models/simulacao.dart';

class SimulacaoController {
  // Metodo POST com parametros
  Future<Simulacao?> getSimulacoes(body) async {
    try {
      var uri = Uri.parse('http://localhost:8000/api/simular');
      String jsonBody = json.encode(body);

      var response = await http.post(
        uri,
        headers: {
          "Content-type": "application/json",
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS"
        },
        body: jsonBody,
      );
      if (response.statusCode == 200) {
        var json = response.body;
        return simulacaoFromJson(json);
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<Simulacao?> getSimulacaoMock() async {
    try {
      String response =
          await rootBundle.loadString('assets/mocks/simulacoes.json');
      return simulacaoFromJson(response);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
