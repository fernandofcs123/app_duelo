import 'dart:convert';
import 'package:app_duelo/services/edison_card_pool_service.dart';
import 'package:http/http.dart' as http;
import '../models/yugioh_card.dart';

class YugiohApiService {
  Future<List<YugiohCard>> buscarCartaPorCodigo(
    String codigo,
  ) async {
    if (!RegExp(r'^\d{8}$').hasMatch(codigo)) {
      return [];
    }

    final uri = Uri.https(
      'db.ygoprodeck.com',
      '/api/v7/cardinfo.php',
      {'id': codigo},
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final dados = data['data'];

      if (dados is! List) {
        return [];
      }

      return dados
        .map((e) => YugiohCard.fromJson(e))
        .toList();
    }

    if (response.statusCode == 400) {
      return [];
    }

    throw Exception(
      'Erro ao consultar o código da carta '
      '(HTTP ${response.statusCode})',
    );
  }

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
          return EdisonCardPoolService.contem(card.id);
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
