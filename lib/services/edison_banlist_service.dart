import 'dart:convert';
import 'package:flutter/services.dart';

class EdisonBanlist {
  final Set<String> forbidden;
  final Set<String> limited;
  final Set<String> semiLimited;

  EdisonBanlist({
    required this.forbidden,
    required this.limited,
    required this.semiLimited,
  });

  String _normalize(String name) {
    return name.trim().toLowerCase();
  }

  /// Retorna quantas cópias podem ser usadas no Edison
  int getLimit(String cardName) {
    final n = _normalize(cardName);

    if (forbidden.any((c) => _normalize(c) == n)) return 0;
    if (limited.any((c) => _normalize(c) == n)) return 1;
    if (semiLimited.any((c) => _normalize(c) == n)) return 2;

    return 3;
  }

  bool isEdisonBanned(String cardName) {
    return forbidden.contains(cardName);
  }
}

class EdisonBanlistService {
  static EdisonBanlist? _cache;

  static Future<EdisonBanlist> load() async {
    if (_cache != null) return _cache!;

    final jsonStr =
        await rootBundle.loadString('assets/edison_banlist.json');
    final data = json.decode(jsonStr);

    _cache = EdisonBanlist(
      forbidden: Set<String>.from(data['forbidden']),
      limited: Set<String>.from(data['limited']),
      semiLimited: Set<String>.from(data['semi_limited']),
    );

    return _cache!;
  }
}
