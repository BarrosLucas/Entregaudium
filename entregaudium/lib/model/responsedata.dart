/*
* Model para o conteúdo do usuário.
*
* OBS: preferi manter os atributos em português (ao contrário do resto do app que
* está em inglês) para simplificar o desenvolvimento e não me  confundir com os
* nomes dos atributos de retorno da API.
* */



import 'historic.dart';

class ResponseData {
  final String nome;
  final String cargo;
  final String descricao;
  final List<Historic> historico;

  ResponseData({
    required this.nome,
    required this.cargo,
    required this.descricao,
    required this.historico,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      nome: json['nome'],
      cargo: json['cargo'],
      descricao: json['descricao'],
      historico: List<Historic>.from(json['historico'].map((e) => Historic.fromJson(e))),
    );
  }
}