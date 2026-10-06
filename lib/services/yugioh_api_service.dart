import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/yugioh_card.dart';

class YugiohApiService {
  Future<List<YugiohCard>> buscarCartas({
    String? nome,
    String? efeito,
    String? tipo,
    bool edison = false,
  }) async {
    final params = <String, String>{};

    if (nome != null && nome.isNotEmpty) {
      params['fname'] = nome;
    }

    if (tipo != null && tipo.isNotEmpty && tipo != 'Todos' && tipo != 'Monster') {
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

      List<YugiohCard> cartas = (data['data'] as List)
        .map((e) => YugiohCard.fromJson(e))
        .toList();

      if (tipo == 'Monster') {
        cartas = cartas.where((card) {
          return card.type.toLowerCase().contains('monster');
        }).toList();
      }

      if (edison) {
        cartas = cartas.where((card) {
          return card.isEdison;
        }).toList();
      }

      if (efeito != null && efeito.trim().isNotEmpty) {
        final busca = efeito.trim().toLowerCase();

        cartas = cartas.where((card) {
          return card.desc.toLowerCase().contains(busca);
        }).toList();
      }
      return cartas;
    } else {
      throw Exception('Erro ao buscar cartas');
    }
  }
}
