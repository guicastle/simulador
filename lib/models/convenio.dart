import 'dart:convert';

List<Convenio> convenioFromJson(String str) =>
    List<Convenio>.from(json.decode(str).map((x) => Convenio.fromJson(x)));

String convenioToJson(List<Convenio> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Convenio {
  Convenio({
    required this.chave,
    required this.valor,
  });

  String chave;
  String valor;

  factory Convenio.fromJson(Map<String, dynamic> json) => Convenio(
        chave: json["chave"],
        valor: json["valor"],
      );

  Map<String, dynamic> toJson() => {
        "chave": chave,
        "valor": valor,
      };
}
