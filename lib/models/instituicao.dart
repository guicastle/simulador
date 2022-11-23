import 'dart:convert';

List<Instituicao> instituicaoFromJson(String str) => List<Instituicao>.from(
    json.decode(str).map((x) => Instituicao.fromJson(x)));

String instituicaoToJson(List<Instituicao> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Instituicao {
  Instituicao({
    required this.chave,
    required this.valor,
  });

  String chave;
  String valor;

  factory Instituicao.fromJson(Map<String, dynamic> json) => Instituicao(
        chave: json["chave"],
        valor: json["valor"],
      );

  Map<String, dynamic> toJson() => {
        "chave": chave,
        "valor": valor,
      };
}
