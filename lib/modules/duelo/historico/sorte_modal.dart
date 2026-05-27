import 'dart:math';
import 'package:flutter/material.dart';

class SorteModal extends StatefulWidget {
  const SorteModal({super.key});

  @override
  State<SorteModal> createState() => _SorteModalState();
}

class _SorteModalState extends State<SorteModal>
    with TickerProviderStateMixin {
  final Random random = Random();

  // =========================
  // MOEDA
  // =========================

  late AnimationController coinController;

  bool isCara = true;
  bool mostrandoResultadoMoeda = false;

  double coinTurns = 40;

  // =========================
  // DADO
  // =========================

  late AnimationController diceController;

  int diceNumber = 1;
  bool mostrandoResultadoDado = false;

  double diceTurns = 40;

  @override
  void initState() {
    super.initState();

    // DIMINUA AQUI PARA FICAR MAIS RÁPIDO
    coinController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // DIMINUA AQUI PARA FICAR MAIS RÁPIDO
    diceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
  }

  @override
  void dispose() {
    coinController.dispose();
    diceController.dispose();
    super.dispose();
  }

  // =========================
  // MOEDA
  // =========================

  Future<void> jogarMoeda() async {
    setState(() {
      mostrandoResultadoMoeda = false;
      //coinTurns += 14;
    });

    isCara = random.nextBool();

    await coinController.forward(from: 0);

    setState(() {
      mostrandoResultadoMoeda = true;
    });
  }

  // =========================
  // DADO
  // =========================

  Future<void> rolarDado() async {
    setState(() {
      mostrandoResultadoDado = false;
      //diceTurns += 12;
    });

    diceNumber = random.nextInt(6) + 1;

    await diceController.forward(from: 0);

    setState(() {
      mostrandoResultadoDado = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // const Text(
            //   "Sorte",
            //   style: TextStyle(
            //     fontSize: 26,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),

            // const SizedBox(height: 30),

            // =========================================
            // MOEDA
            // =========================================

            const Text(
              "Cara ou Coroa",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            AnimatedBuilder(
              animation: coinController,
              builder: (context, child) {
                final angle =
                    coinController.value * pi * coinTurns;

                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(angle),
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,

                      // aparência tipo moeda de 1 real
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFD4AF37),
                          Color(0xFFFFE082),
                          Color(0xFFB8860B),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),

                      border: Border.all(
                        color: const Color(0xFF8B7500),
                        width: 5,
                      ),

                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        )
                      ],
                    ),
                    child: Center(
                      child: mostrandoResultadoMoeda
                          ? Text(
                              isCara
                                  ? "CARA"
                                  : "COROA",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight:
                                    FontWeight.bold,
                                color: Colors.black87,
                              ),
                            )
                          : const Icon(
                              Icons.monetization_on,
                              size: 60,
                              color: Colors.black54,
                            ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: jogarMoeda,
              child: const Text("Jogar Moeda"),
            ),

            const SizedBox(height: 40),

            // =========================================
            // DADO
            // =========================================

            const Text(
              "Dado",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            AnimatedBuilder(
              animation: diceController,
              builder: (context, child) {
                final angle =
                    diceController.value * pi * diceTurns;

                return Transform.rotate(
                  angle: angle,
                  child: Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.black87,
                        width: 4,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        )
                      ],
                    ),
                    child: Center(
                      child: mostrandoResultadoDado
                          ? Text(
                              "$diceNumber",
                              style: const TextStyle(
                                fontSize: 56,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            )
                          : const Icon(
                              Icons.casino,
                              size: 60,
                              color: Colors.black54,
                            ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: rolarDado,
              child: const Text("Rolar Dado"),
            ),
          ],
        ),
      ),
    );
  }
}