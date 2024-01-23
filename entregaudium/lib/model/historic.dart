/*
* Model para os históricos do usuário.
*
* OBS: preferi manter os atributos em português (ao contrário do resto do app que
* está em inglês) para simplificar o desenvolvimento e não me  confundir com os
* nomes dos atributos de retorno da API.
* */



class Historic {
  final String quando;
  final dynamic valor;
  final int qtd;
  final int avaliacao;

  Historic({required this.quando, required this.valor, required this.qtd, required this.avaliacao});

  factory Historic.fromJson(Map<String, dynamic> json) {
    return Historic(
      quando: json['quando'],
      valor: json['valor'],
      qtd: json['qtd'],
      avaliacao: json['avaliacao']
    );
  }
}
