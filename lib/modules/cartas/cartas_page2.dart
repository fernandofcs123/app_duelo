import 'package:app_duelo/models/yugioh_card.dart';
import 'package:app_duelo/modules/cartas/detalhe_carta/card_details_page.dart';
import 'package:app_duelo/modules/cartas/widgets/carta_card_widget2.dart';
import 'package:app_duelo/modules/cartas/widgets/filtro_cartas_widget.dart';
import 'package:app_duelo/modules/cartas/widgets/filtro_toggle_widget.dart';
import 'package:app_duelo/services/yugioh_api_service.dart';
import 'package:flutter/material.dart';

class CartasPage2 extends StatefulWidget {
  const CartasPage2({super.key});

  @override
  State<CartasPage2> createState() => _CartasPageState();
}

class _CartasPageState extends State<CartasPage2> {
  final YugiohApiService api = YugiohApiService();

  String nome = '';
  String efeito = '';
  String tipo = 'Todos';

  bool carregando = false;
  bool edison = false;

  // Controla se os filtros estão abertos ou fechados
  bool filtrosExpandidos = true;

  List<YugiohCard> cartas = [];

  Future<void> buscarCartas() async {
    FocusScope.of(context).unfocus();

    setState(() => carregando = true);

    final resultado = await api.buscarCartas(
      nome: nome,
      efeito: efeito,
      tipo: tipo,
      edison: edison,
    );

    setState(() {
      cartas = resultado;
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Cartas"),
      // ),

      body: Stack(
        children: [
          Column(
            children: [
              AnimatedSize(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                child: filtrosExpandidos
                    ? FiltroCartasWidget(
                      onLimpar: () {
                        setState(() {
                          nome = '';
                          efeito = '';
                          tipo = 'Todos';
                          cartas = [];
                          edison = false;
                        });
                      },
                        onBuscar: buscarCartas,
                        onNomeChanged: (v) => nome = v,
                        onEfeitoChanged: (v) => efeito = v,
                        onTipoChanged: (v) => tipo = v,
                        onEdisonChanged: (v) => edison = v,
                      )
                    : const SizedBox.shrink(),
              ),

              Expanded(
                child: carregando
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : cartas.isEmpty
                        ? const Center(
                            child: Text("Use os filtros e busque cartas"),
                          )
                        : GridView.builder(
                            padding: const EdgeInsets.all(8),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 0.7,
                            ),
                            itemCount: cartas.length,
                            itemBuilder: (_, index) {
                              final card = cartas[index];

                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          CardDetailsPage(card: card),
                                    ),
                                  );
                                },
                                child: CartaCardWidget2(
                                  card: card,
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),

          // BOTÃO FLUTUANTE
          Positioned(
            top: 16,
            right: 16,
            child: FiltroToggleWidget(
              expandido: filtrosExpandidos,
              onToggle: () {
                setState(() {
                  filtrosExpandidos = !filtrosExpandidos;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}