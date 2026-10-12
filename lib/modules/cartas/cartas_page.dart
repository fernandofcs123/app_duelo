import 'package:app_duelo/models/yugioh_card.dart';
import 'package:app_duelo/modules/cartas/detalhe_carta/card_details_page.dart';
import 'package:app_duelo/modules/cartas/widgets/carta_card_widget.dart';
import 'package:app_duelo/modules/cartas/widgets/filtro_cartas_widget.dart';
import 'package:app_duelo/modules/cartas/widgets/filtro_toggle_widget.dart';
import 'package:app_duelo/services/card_recognition_service.dart';
import 'package:app_duelo/services/yugioh_api_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CartasPage extends StatefulWidget {
  const CartasPage({super.key});

  @override
  State<CartasPage> createState() => _CartasPageState();
}

class _CartasPageState extends State<CartasPage> {
  final YugiohApiService api = YugiohApiService();
  final ImagePicker picker = ImagePicker();
  final CardRecognitionService reconhecimento = CardRecognitionService();

  String nomeParaWidget = '';
  String nome = '';
  String efeito = '';
  String tipo = 'Todos';

  bool carregando = false;
  bool edison = false;

  // Controla se os filtros estão abertos ou fechados
  bool filtrosExpandidos = true;

  Future<void> identificarCarta() async {
    try {
      final foto = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 90,
      );

      if (foto == null || !mounted) return;

      setState(() {
        carregando = true;
      });

      final texto = await reconhecimento.reconhecerTexto(foto.path);

      if (!mounted) return;

      final linhas = texto
        .split('\n')
        .map((linha) => linha.trim())
        .where((linha) => linha.isNotEmpty)
        .toList();

      if (linhas.isEmpty) {
        setState(() {
          carregando = false;
        });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Não consegui reconhecer o texto. Tente outra foto',
          ),
        ),
      );
      return;
      }
      final nomeReconhecido = linhas.first;

      setState(() {
        nome = nomeReconhecido;
        nomeParaWidget = nomeReconhecido;
        efeito = '';
        carregando = false;
      });

      await buscarCartas();
    } catch (e) {
      if (!mounted) return;

      setState(() {
        carregando = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao identificar a carta: $e'),
        ),
      );
    }
  }

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
                        nomeInicial: nomeParaWidget,
                        onCamera: identificarCarta,
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
                                child: CartaCardWidget(
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