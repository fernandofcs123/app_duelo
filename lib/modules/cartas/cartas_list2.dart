import 'package:app_duelo/models/yugioh_card.dart';
import 'package:app_duelo/modules/cartas/widgets/carta_card_widget.dart';
import 'package:flutter/material.dart';

class CartasList2 extends StatefulWidget {
  final Future<List<YugiohCard>> future;

  const CartasList2({super.key, required this.future});

  @override
  State<CartasList2> createState() => _CartasListState();
}

class _CartasListState extends State<CartasList2>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _controller = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return FutureBuilder<List<YugiohCard>>(
      future: widget.future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }

        final cartas = snapshot.data!;

        return ListView.builder(
          key: const PageStorageKey('cartas_list'),
          controller: _controller,
          itemCount: cartas.length,
          itemBuilder: (context, index) {
            final card = cartas[index];
            return CartaCardWidget(card: card);
          },
        );
      },
    );
  }
}
