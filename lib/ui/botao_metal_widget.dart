import 'package:flutter/material.dart';

class BotaoMetalWidget extends StatelessWidget {
  final bool flagAtivo;
  final String texto;
  final VoidCallback onToggle;
  final Color cor;

  const BotaoMetalWidget({
    super.key,
    required this.texto,
    required this.cor,
    required this.flagAtivo,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: flagAtivo
          ? cor
          : const Color.fromARGB(255, 198, 198, 198),
        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 12),),
      onPressed: onToggle, 
      child: Text(texto),
      );
    
  }
}