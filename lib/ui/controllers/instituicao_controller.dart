import 'package:flutter/services.dart';
import 'package:teste_flutter/models/instituicao.dart';
import 'package:http/http.dart' as http;

class InstituicaoController {
  Future<List<Instituicao>?> getInstituicoes() async {
    var client = http.Client();

    var uri = Uri.parse('http://127.0.0.1:8000/api/instituicao');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return instituicaoFromJson(json);
    }
  }

  Future<List<Instituicao>?> getInstituicoesMock() async {
    try {
      String response =
          await rootBundle.loadString('assets/mocks/instituicoes.json');
      print(response);
      return instituicaoFromJson(response);
    } catch (e) {
      print(e);
    }
  }
}
