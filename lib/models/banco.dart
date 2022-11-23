import 'dart:convert';

Banco bancoFromJson(String str) => Banco.fromJson(json.decode(str));

String bancoToJson(Banco data) => json.encode(data.toJson());

class Banco {
  Banco({
    this.taxa,
    this.parcelas,
    this.valorParcela,
    this.convenio,
    this.imgAssetBanco,
    this.chaveBanco,
  });

  double? taxa;
  int? parcelas;
  double? valorParcela;
  String? convenio;
  String? imgAssetBanco;
  String? chaveBanco;

  factory Banco.fromJson(Map<String, dynamic> json) => Banco(
        taxa: json["taxa"].toDouble(),
        parcelas: json["parcelas"],
        valorParcela: json["valor_parcela"].toDouble(),
        convenio: json["convenio"],
        imgAssetBanco: json["img_asset_banco"],
        chaveBanco: json["chaveBanco"],
      );

  Map<String, dynamic> toJson() => {
        "taxa": taxa,
        "parcelas": parcelas,
        "valor_parcela": valorParcela,
        "convenio": convenio,
        "img_asset_banco": imgAssetBanco,
        "chaveBanco": chaveBanco,
      };
}
