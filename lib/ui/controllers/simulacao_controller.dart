import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:teste_flutter/models/simulacao.dart';

class SimulacaoController {
  // Metodo POST com parametros
  Future<Simulacao?> getSimulacoes() async {
    var client = http.Client();

    var uri = Uri.parse('URLBASE/api/simular');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return simulacaoFromJson(json);
    }
  }

  Future<Simulacao?> getSimulacaoMock() async {
    try {
      String response =
          await rootBundle.loadString('assets/mocks/simulacoes.json');
      print(response);
      return simulacaoFromJson(response);
    } catch (e) {
      print(e);
    }
  }
}
