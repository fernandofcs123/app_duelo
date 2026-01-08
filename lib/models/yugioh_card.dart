class YugiohCard {
  final int id;
  final String name;
  final String type;
  final String desc;
  final String imageUrl;
  final String? archetype;

  YugiohCard({
    required this.id,
    required this.name,
    required this.type,
    required this.desc,
    required this.imageUrl,
    this.archetype,
  });

  factory YugiohCard.fromJson(Map<String, dynamic> json) {
    return YugiohCard(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      desc: json['desc'],
      archetype: json['archetype'],
      imageUrl: json['card_images'][0]['image_url'],
    );
  }
}
