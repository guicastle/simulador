import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:teste_flutter/models/convenio.dart';

class ConvenioController {
  Future<List<Convenio>?> getConvenios() async {
    try {
      var client = http.Client();

      var uri = Uri.parse('http://127.0.0.1:8000/api/convenio');
      var response = await client.get(uri);
      if (response.statusCode == 200) {
        var json = response.body;
        return convenioFromJson(json);
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<List<Convenio>?> getConveniosMock() async {
    try {
      String response =
          await rootBundle.loadString('assets/mocks/convenios.json');
      print(response);
      return convenioFromJson(response);
    } catch (e) {
      print(e);
    }
  }
}
