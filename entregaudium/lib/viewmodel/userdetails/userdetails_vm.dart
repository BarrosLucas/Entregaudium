// viewmodel.dart
import 'package:flutter/material.dart';

import '../../model/apiresponse.dart';
import '../../repositories/apirepository.dart';

class UserDetailsViewModel with ChangeNotifier{
  final ApiRepository _repository = ApiRepository();

  int? _totalDeliveries;
  double? _feedback;
  double? _value;

  ApiResponse? _apiResponse;
  ApiResponse? get apiResponse => _apiResponse;

  int? get totalDeliveries => _totalDeliveries;
  double? get feedback => _feedback;
  double? get value => _value;

  Future<ApiResponse?> fetchData() async {
    try {
      _apiResponse = await _repository.fetchData();


      /*
      * Os dados são lidos e traduzidos em estatísticas usando fold, map e reduce.
      * */
      _value = _apiResponse!.response.historico.fold(0, (sum, item) => sum! + (item.valor is int ? item.valor.toDouble() : item.valor));
      _totalDeliveries = _apiResponse!.response.historico.fold(0, (sum, item) => sum! + item.qtd);
      _feedback = _apiResponse!.response.historico.isEmpty ? 0 : _apiResponse!.response.historico.map((item) => item.avaliacao).reduce((a, b) => a + b) / _apiResponse!.response.historico.length;


      return _apiResponse;
    } catch (e) {
      print('Erro: $e');
    }
    return null;
  }


}
