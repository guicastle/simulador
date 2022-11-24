import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teste_flutter/models/banco.dart';
import 'package:teste_flutter/models/convenio.dart';
import 'package:teste_flutter/models/instituicao.dart';
import 'package:teste_flutter/ui/controllers/convenios_controller.dart';
import 'package:teste_flutter/ui/controllers/instituicao_controller.dart';
import 'package:teste_flutter/ui/controllers/simulacao_controller.dart';
import 'package:teste_flutter/ui/pages/home/components/simulacao_component.dart';
import 'package:teste_flutter/ui/values/colors.dart';
import 'package:teste_flutter/ui/values/currency_formatter.dart';

import '../../../models/simulacao.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Simulacao? simulacoes;
  List<Instituicao>? listInstitucoes;
  List<Convenio>? listConvenio = [];
  List<Banco> listBancos = [];

  var isLoading = false;

  final _controllerValor = TextEditingController();
  List<String> parcelas = <String>['36', '48', '60', '72', '84'];
  String selectedParcela = "0";
  String selectedInstituicao = "";
  String selectedConvenio = "";

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    listInstitucoes = await InstituicaoController().getInstituicoes();
    // listInstitucoes = await InstituicaoController().getInstituicoesMock();

    listConvenio = await ConvenioController().getConvenios();
    // listConvenio = await ConvenioController().getConveniosMock();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text("Simulador App"),
        backgroundColor: primaryColor,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _valorEmprestismo(),
              const SizedBox(height: 15),
              _qtdParcelas(),
              const SizedBox(height: 15),
              _qtdInstituicao(),
              const SizedBox(height: 15),
              _qtdConvenios(),
              // Botão Simular
              _btnSimular(),

              // Lista de retorno da API
              Visibility(
                visible: isLoading,
                child: Expanded(
                  child: ListView.builder(
                    itemCount: listBancos.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SimulacaoComponent(
                            image: listBancos[index].imgAssetBanco.toString(),
                            title:
                                '${_controllerValor.text} - ${listBancos[index].parcelas} x  R\$ ${listBancos[index].valorParcela}',
                            subtitle:
                                '${listBancos[index].chaveBanco} (${listBancos[index].convenio}) - ${listBancos[index].taxa}%',
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _valorEmprestismo() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Campo obrigatório!';
        }
        return null;
      },
      controller: _controllerValor,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        CurrencyInputFormatter()
      ],
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Valor do empréstimo',
      ),
      keyboardType: TextInputType.number,
    );
  }

  Widget _qtdParcelas() {
    return DropdownButtonFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Quantidade de parcelas',
      ),
      items: parcelas.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedParcela = value.toString();
        });
      },
    );
  }

  Widget _qtdInstituicao() {
    return DropdownButtonFormField<Instituicao>(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Instituições',
      ),
      items: listInstitucoes
          ?.map<DropdownMenuItem<Instituicao>>((Instituicao value) {
        return DropdownMenuItem<Instituicao>(
          value: value,
          child: Text(value.chave),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedInstituicao = value!.chave.toString();
        });
      },
    );
  }

  Widget _qtdConvenios() {
    return DropdownButtonFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Convênios',
      ),
      items: listConvenio?.map<DropdownMenuItem<Convenio>>((Convenio value) {
        return DropdownMenuItem<Convenio>(
          value: value,
          child: Text(value.chave),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedConvenio = value!.chave.toString();
        });
      },
    );
  }

  _btnSimular() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.1,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
          ),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              Map<String, dynamic> json = {
                "valor_emprestimo": double.parse(_controllerValor.text
                    .replaceAll('R\$', '')
                    .replaceAll('.', '')
                    .replaceAll(',', '.')
                    .trim()),
                "instituicoes":
                    selectedInstituicao == "" ? [] : [selectedInstituicao],
                "convenios": selectedConvenio == "" ? [] : [selectedConvenio],
                "parcelas": int.parse(selectedParcela)
              };

              // Lista retorno da API
              simulacoes = await SimulacaoController().getSimulacoes(json);

              // Simular MOCK
              //simulacoes = await SimulacaoController().getSimulacaoMock();

              // Identifica e salva campo auxiliar para assets, interessante que essa imagem seja direto da API
              simulacoes?.bmg?.forEach((element) {
                element.imgAssetBanco = 'assets/images/logo-banco-bmg.png';
                element.chaveBanco = 'BMG';
                listBancos.add(element);
              });
              simulacoes?.ole?.forEach((element) {
                element.imgAssetBanco = 'assets/images/ole-consignado-logo.png';
                element.chaveBanco = 'OLE';
                listBancos.add(element);
              });
              simulacoes?.pan?.forEach((element) {
                element.imgAssetBanco = 'assets/images/banco-pan-logo-v2.png';
                element.chaveBanco = 'PAN';
                listBancos.add(element);
              });

              if (simulacoes != null) {
                setState(() {
                  isLoading = !isLoading;
                });
              }
            }
          },
          child: const Text(
            'SIMULAR',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
