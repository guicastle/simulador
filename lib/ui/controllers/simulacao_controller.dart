import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:teste_flutter/models/convenio.dart';
import 'package:teste_flutter/models/simulacao.dart';

class SimulacaoController {
  // Metodo POST com parametros
  Future<Simulacao?> getSimulacoes(body) async {
    try {
      var client = http.Client();

      var uri = Uri.parse('http://localhost:8000/api/simular');
      final headers = {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*"
      };
      String jsonBody = json.encode(body);

      var response = await client.post(
        uri,
        headers: headers,
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

  Future<Simulacao?> filtrarConvencio(List<Convenio> convenio) async {}
}
