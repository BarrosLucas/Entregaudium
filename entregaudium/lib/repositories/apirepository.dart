// repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/apiresponse.dart';

class ApiRepository {
  final URL = "https://dbgapi-gamadev.taximachine.com.br/ps/perfil.php";

  Future<ApiResponse> fetchData() async {
    final response = await http.get(Uri.parse(URL));
    print(response.body);
    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);
      return ApiResponse.fromJson(decodedResponse);
    } else {
      throw Exception('Erro na requisição: ${response.statusCode}');
    }
  }
}
