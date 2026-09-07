import 'package:flutter/material.dart';
import '../../../models/yugioh_card.dart';
import '../../../services/edison_banlist_service.dart';

class CartaCardWidget2 extends StatelessWidget {
  final YugiohCard card;

  const CartaCardWidget2({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: _cardImage(),
    );
  }

  // ================= IMAGE =================
  Widget _cardImage() {
    return AspectRatio(
      aspectRatio: 0.68,
      child: Image.network(
        card.imageUrl,
        // width: 90,
        // height: 130,
        fit: BoxFit.cover,
      ),
    );
  }

  // ================= INFO =================
  Widget _cardInfo(EdisonBanlist banlist) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          card.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          card.type,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade700,
          ),
        ),

        const SizedBox(height: 6),


        if (card.atk != null) ...[
          Text(
            'ATK ${card.atk} / DEF ${card.def ?? '-'}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            card.desc,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13),
          ),
        ] else ...[
          Text(
            card.desc,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13),
          ),
        ],

        const SizedBox(height: 8),

        Row(
          children: [
            _edisonBadge(),
            const SizedBox(width: 8),
            _limitBadge(),
          ],
        ),
      ],
    );
  }

  // ================= BADGES =================

  Widget _edisonBadge() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: card.isEdison ? Colors.green : Colors.red,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      card.isEdison ? 'Edison' : 'Não Edison',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}



  Widget _limitBadge() {
  if (!card.isEdison) return const SizedBox();

  return FutureBuilder<EdisonBanlist>(
    future: EdisonBanlistService.load(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return const SizedBox();

      final banlist = snapshot.data!;
      final limit = banlist.getLimit(card.name);

      if (limit >= 3) return const SizedBox();

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: limit == 0 ? Colors.red : Colors.indigo,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          'Limite $limit',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    },
  );
}


}
