
import 'dart:convert';

import 'package:flutter/services.dart';

import 'edison_card_pool_service.dart';

class EdisonBanlistService {
  static Set<String>? _proibidas;
  static Map<String, int>? _limites;
  static bool _carregado = false;

  static Future<void> carregar() async {
    if (_carregado) return;

    await EdisonCardPoolService.carregar();

    final jsonTexto = await rootBundle.loadString(
      'assets/edison_banlist.json',
    );

    final dados = jsonDecode(jsonTexto) as Map<String, dynamic>;

    _proibidas = (dados['forbidden'] as List<dynamic>? ?? [])
        .map((nome) => nome.toString())
        .toSet();

    final csv = await rootBundle.loadString(
      'assets/edison_banlist.csv',
    );

    final limites = <String, int>{};

    for (final linha in csv.split(RegExp(r'\r?\n'))) {
      final partes = linha.trim().split(',');

      if (partes.length != 2) continue;

      final codigo = partes[0].trim();
      final quantidade = int.tryParse(partes[1].trim());

      if (RegExp(r'^\d{8}$').hasMatch(codigo) &&
          quantidade != null &&
          (quantidade == 1 || quantidade == 2)) {
        limites[codigo] = quantidade;
      }
    }

    _limites = limites;
    _carregado = true;
  }

  // Retorna null se a carta não for Edison.
  // Retorna 0, 1, 2 ou 3 se for Edison.
  static int? limite({
    required String codigo,
    required String nome,
  }) {
    if (!_carregado) {
      throw StateError(
        'Carregue EdisonBanlistService antes de consultar os limites.',
      );
    }

    // 1. Proibidas: comparação exata do nome.
    if (_proibidas!.contains(nome)) {
      return 0;
    }

    final codigoNormalizado = codigo.trim().padLeft(8, '0');

    // 2. Cartas limitadas ou semilimitadas.
    final limiteCsv = _limites![codigoNormalizado];

    if (limiteCsv != null) {
      return limiteCsv;
    }

    // 3. Carta Edison sem restrição específica.
    if (EdisonCardPoolService.contem(codigoNormalizado)) {
      return 3;
    }

    // 4. Carta fora do formato Edison.
    return null;
  }
}
