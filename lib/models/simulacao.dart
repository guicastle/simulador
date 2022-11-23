import 'dart:convert';

import 'banco.dart';

Simulacao simulacaoFromJson(String str) => Simulacao.fromJson(json.decode(str));

String simulacaoToJson(Simulacao data) => json.encode(data.toJson());

class Simulacao {
  Simulacao({
    this.bmg,
    this.pan,
    this.ole,
  });

  List<Banco>? bmg;
  List<Banco>? pan;
  List<Banco>? ole;

  factory Simulacao.fromJson(Map<String, dynamic> json) => Simulacao(
        bmg: List<Banco>.from(json["BMG"].map((x) => Banco.fromJson(x))),
        pan: List<Banco>.from(json["PAN"].map((x) => Banco.fromJson(x))),
        ole: List<Banco>.from(json["OLE"].map((x) => Banco.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "BMG": List<dynamic>.from(bmg!.map((x) => x.toJson())),
        "PAN": List<dynamic>.from(pan!.map((x) => x.toJson())),
        "OLE": List<dynamic>.from(ole!.map((x) => x.toJson())),
      };
}
