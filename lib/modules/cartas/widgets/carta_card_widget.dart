
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
      child: FutureBuilder<void>(
        future: EdisonBanlistService.carregar(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Erro ao carregar banlist'),
            );
          }

          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return _cardImage();
        },
      ),
    );
  }

  Widget _cardImage() {
    final isEdison = card.isEdison;
    final limite = card.edisonLimit;

    return AspectRatio(
      aspectRatio: 0.68,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            card.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Icon(Icons.broken_image, size: 40),
              );
            },
          ),

          // Identificação do formato Edison.
          Positioned(
            top: 25,
            left: 4,
            child: _badge(
              texto: isEdison ? 'EDISON' : 'TCG',
              cor: isEdison ? Colors.green : Colors.red,
            ),
          ),

          // Limite de cópias: aparece somente para cartas Edison
          // proibidas, limitadas ou semilimitadas.
          if (isEdison && limite != null && limite < 3)
            Positioned(
              top: 47,
              left: 4,
              child: _badge(
                texto: switch (limite) {
                  0 => '0',
                  1 => '1',
                  2 => '2',
                  _ => '',
                },
                cor: limite == 0 ? Colors.red : Colors.indigo,
              ),
            ),
        ],
      ),
    );
  }

  Widget _badge({
    required String texto,
    required Color cor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: cor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        texto,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
