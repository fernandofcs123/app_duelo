import 'package:app_duelo/services/edison_card_pool_service.dart';
import 'package:flutter/material.dart';
import '../../../models/yugioh_card.dart';
import '../../../services/edison_banlist_service.dart';

class CartaCardWidget extends StatelessWidget {
  final YugiohCard card;

  const CartaCardWidget({super.key, required this.card});

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
  // ================= BADGES =================

  Widget _edisonBadge() {
    final isEdison = EdisonCardPoolService.contem(card.id);

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: isEdison ? Colors.green : Colors.red,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      isEdison ? 'Edison' : 'Não Edison',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}



  Widget _limitBadge() {
  if (!EdisonCardPoolService.contem(card.id)) return const SizedBox();

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
