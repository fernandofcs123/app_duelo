import 'package:flutter/material.dart';

import '../../models/yugioh_card.dart';
import '../../services/yugioh_api_service.dart';
import 'widgets/filtro_cartas_widget.dart';
import 'widgets/carta_card_widget.dart';

class CartasPage extends StatefulWidget {
  const CartasPage({super.key});

  @override
  State<CartasPage> createState() => _CartasPageState();
}

class _CartasPageState extends State<CartasPage> {
  final YugiohApiService api = YugiohApiService();

  String nome = '';
  String tipo = 'Todos';
  bool edison = true;

  Future<List<YugiohCard>>? _future;

  void buscarCartas() {
    setState(() {
      _future = api.buscarCartas(
        nome: nome,
        tipo: tipo,
        // edison: edison,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cartas")),
      body: Column(
        children: [
          FiltroCartasWidget(
            onBuscar: buscarCartas,
            onNomeChanged: (v) => nome = v,
            onTipoChanged: (v) => tipo = v,
            onEdisonChanged: (v) => edison = v,
          ),
          Expanded(
            child: _future == null
                ? const Center(
                    child: Text("Use os filtros e busque cartas"),
                  )
                : FutureBuilder<List<YugiohCard>>(
                    future: _future,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }

                      final cartas = snapshot.data!;

                      return ListView.builder(
                        itemCount: cartas.length,
                        itemBuilder: (_, index) {
                          return CartaCardWidget(
                            card: cartas[index],
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
