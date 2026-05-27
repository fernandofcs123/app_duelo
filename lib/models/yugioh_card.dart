import '../constants/edison_set.dart';

class YugiohCard {
  final String name;
  final String type;
  final String desc;
  final String? race;
  final int? atk;
  final int? def;
  final List<dynamic>? cardImages;
  final List<dynamic>? cardSets;
  final Map<String, dynamic>? banlistInfo;

  YugiohCard({
    required this.name,
    required this.type,
    required this.desc,
    this.race,
    this.atk,
    this.def,
    this.cardImages,
    this.cardSets,
    this.banlistInfo,
  });

  factory YugiohCard.fromJson(Map<String, dynamic> json) {
    return YugiohCard(
      name: json['name'],
      type: json['type'],
      desc: json['desc'],
      race: json['race'],
      atk: json['atk'],
      def: json['def'],
      cardImages: json['card_images'],
      cardSets: json['card_sets'],
      banlistInfo: json['banlist_info'],
    );
  }

  // ================= IMAGE =================
  String get imageUrl =>
      cardImages != null && cardImages!.isNotEmpty
          ? cardImages!.first['image_url']
          : '';

  // ================= EDISON (SET BASED) =================
  bool get isEdison {
    if (cardSets == null) return false;

    return cardSets!.any((set) {
      final rawCode = set['set_code'];
      if (rawCode == null) return false;

      final prefix = rawCode.toString().split('-').first;
      return edisonSetCodes.contains(prefix);
    });
  }

  // ================= BANLIST =================
  int get tcgLimit {
    if (banlistInfo == null) return 3;

    switch (banlistInfo!['ban_tcg']) {
      case 'Forbidden':
        return 0;
      case 'Limited':
        return 1;
      case 'Semi-Limited':
        return 2;
      default:
        return 3;
    }
  }
}
