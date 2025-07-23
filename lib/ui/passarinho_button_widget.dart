import 'package:app_duelo/modules/calculadora/passarinho_modal.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PassarinhoButtonWidget extends StatelessWidget {
  final int valorSelecionado;
  final ValueChanged<int> onValorSelecionado;

  const PassarinhoButtonWidget({
    super.key,
    required this.onValorSelecionado,
    required this.valorSelecionado,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final int? resultado = await showDialog<int>(
          context: context,
          builder: (context) => const PassarinhoModal(),
        );

        if (resultado != null) {
          onValorSelecionado(resultado);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: valorSelecionado != 0
          ? const Color.fromARGB(255, 171, 210, 242)
          : null,
        minimumSize: const Size(60, 40),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        alignment: Alignment.center,
      ),
      child: valorSelecionado == 0
        ? const Icon(LucideIcons.bird, size: 20)
        : Text(
          "$valorSelecionado",
          maxLines: 1,
          softWrap: false,
          overflow: TextOverflow.visible,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18),
        )
    );
  }
}