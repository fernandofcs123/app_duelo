import 'package:app_duelo/models/yugioh_card.dart';
import 'package:app_duelo/modules/cartas/detalhe_carta/card_details_page.dart';
import 'package:app_duelo/modules/cartas/widgets/carta_card_widget.dart';
import 'package:app_duelo/modules/cartas/widgets/filtro_cartas_widget.dart';
import 'package:app_duelo/services/yugioh_api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class CartasPage extends StatefulWidget {
  const CartasPage({super.key});

  @override
  State<CartasPage> createState() => _CartasPageState();
}

class _CartasPageState extends State<CartasPage> {
  final YugiohApiService api = YugiohApiService();
  final ScrollController _scrollController = ScrollController();

  String nome = '';
  String efeito = '';
  String tipo = 'Todos';
  bool edison = false;

  bool carregando = false;
  bool mostrarFiltros = true;
  List<YugiohCard> cartas = [];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> buscarCartas() async {
    FocusScope.of(context).unfocus(); // 🔑 evita rebuild por teclado

    setState(() => carregando = true);

    final resultado = await api.buscarCartas(
      nome: nome,
      tipo: tipo,
    );

    setState(() {
      cartas = resultado;
      carregando = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (mostrarFiltros) {
          setState(() {
            mostrarFiltros = false;
          });
        }
      }

      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!mostrarFiltros) {
          setState(() {
            mostrarFiltros = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cartas")),
      body: Column(
        children: [
          ClipRect(
            child: AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              child: mostrarFiltros
                  ? Column(
                      children: [
                        FiltroCartasWidget(
                          onLimpar: () {
                            setState(() {
                              nome = '';
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
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ),
          Expanded(
            child: carregando
                ? const Center(child: CircularProgressIndicator())
                : cartas.isEmpty
                    ? const Center(
                        child: Text("Use os filtros e busque cartas"),
                      )
                    : ListView.builder(
                        controller: _scrollController,
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
                            child: CartaCardWidget(card: card),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
