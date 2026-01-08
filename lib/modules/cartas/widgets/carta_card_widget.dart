import 'package:flutter/material.dart';
import '../../../models/yugioh_card.dart';

class CartaCardWidget extends StatelessWidget {
  final YugiohCard card;

  const CartaCardWidget({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Futuro: abrir detalhes da carta
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ImagemCarta(card.imageUrl),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: _InfoCarta(card),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImagemCarta extends StatelessWidget {
  final String imageUrl;

  const _ImagemCarta(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        bottomLeft: Radius.circular(12),
      ),
      child: Image.network(
        imageUrl,
        width: 90,
        height: 130,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const SizedBox(
            width: 90,
            height: 130,
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        },
        errorBuilder: (_, __, ___) {
          return const SizedBox(
            width: 90,
            height: 130,
            child: Icon(Icons.broken_image, size: 40),
          );
        },
      ),
    );
  }
}

class _InfoCarta extends StatelessWidget {
  final YugiohCard card;

  const _InfoCarta(this.card);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          card.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        _ChipInfo(card.type),
        if (card.archetype != null) ...[
          const SizedBox(height: 6),
          _ChipInfo(card.archetype!),
        ],
        const SizedBox(height: 8),
        Text(
          card.desc,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }
}

class _ChipInfo extends StatelessWidget {
  final String label;

  const _ChipInfo(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.indigo.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.indigo,
        ),
      ),
    );
  }
}
