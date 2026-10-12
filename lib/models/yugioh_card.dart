import 'package:app_duelo/services/edison_banlist_service.dart';

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
  final String id;

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
    required this.id,
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
      id: json['id'].toString(),
    );
  }

  // ================= IMAGE =================
  String get imageUrl =>
      cardImages != null && cardImages!.isNotEmpty
          ? cardImages!.first['image_url']
          : '';
  // ================= BANLIST =================
  int? get edisonLimit {
    return EdisonBanlistService.limite(
      codigo: id.trim().padLeft(8, '0'), 
      nome: name
    ); 

  } 
  
  bool get isEdison => edisonLimit != null;
}
