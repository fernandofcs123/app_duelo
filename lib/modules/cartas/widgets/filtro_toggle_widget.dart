import 'package:flutter/material.dart';

class FiltroToggleWidget extends StatelessWidget {
  final bool expandido;
  final VoidCallback onToggle;

  const FiltroToggleWidget({
    super.key,
    required this.expandido,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      onPressed: onToggle,
      backgroundColor: Colors.lightBlue.withOpacity(0.5),
      child: Icon(
        expandido
            ? Icons.keyboard_arrow_up
            : Icons.keyboard_arrow_down,
      ),
    );
  }
}