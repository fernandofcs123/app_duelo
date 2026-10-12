import 'package:flutter/services.dart';

class EdisonCardPoolService {
  static Set<String>? _codigos;

  static Future<void> carregar() async {
    if (_codigos != null) return;
    
    final conteudo = await rootBundle.loadString(
      'assets/edison_card_codes.csv',
    );

    _codigos = conteudo
      .split(RegExp(r'\r?\n'))
      .map((linha) => linha.trim())
      .where((codigo) => RegExp(r'^\d{8}$').hasMatch(codigo))
      .toSet();
  }

  static bool contem(String codigo) {
    return _codigos?.contains(codigo) ?? false;
  }
}