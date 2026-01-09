import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/yugioh_card.dart';

class YugiohApiService {
  Future<List<YugiohCard>> buscarCartas({
    String? nome,
    String? tipo,
  }) async {
    final params = <String, String>{};

    if (nome != null && nome.isNotEmpty) {
      params['fname'] = nome;
    }

    if (tipo != null && tipo.isNotEmpty && tipo != 'Todos') {
      params['type'] = tipo;
    }

    final uri = Uri.https(
      'db.ygoprodeck.com',
      '/api/v7/cardinfo.php',
      params,
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['data'] as List)
          .map((e) => YugiohCard.fromJson(e))
          .toList();
    } else {
      throw Exception('Erro ao buscar cartas');
    }
  }
}
