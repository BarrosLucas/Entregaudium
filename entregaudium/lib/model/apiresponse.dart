import 'package:entregaudium/model/responsedata.dart';

/*
* Model para a resposta da API. Um atributo para receber a mensagem de sucesso e
* outro para receber o conteúdo propriamente tipo do usuário, conforme a estrutura
* da API.
*
* OBS: preferi manter os atributos em português (ao contrário do resto do app que
* está em inglês) para simplificar o desenvolvimento e não me  confundir com os
* nomes dos atributos de retorno da API.
* */

class ApiResponse {
  final String success;
  final ResponseData response;

  ApiResponse({required this.success, required this.response});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['success'],
      response: ResponseData.fromJson(json['response']),
    );
  }
}
