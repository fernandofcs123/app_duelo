import 'package:flutter/material.dart';

class BotaoNumeroWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String texto;

  const BotaoNumeroWidget({
    super.key,
    required this.onPressed,
    required this.texto,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 8),
        // textStyle: TextStyle(fontSize: 18),
        minimumSize: Size(50, 50),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.center,
      ),
      onPressed: onPressed, 
      child: OverflowBox(
        maxWidth: double.infinity,
        child: Text(
          texto,
          maxLines: 1,
          softWrap: false,
          overflow: TextOverflow.visible,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      )
    );
  }
}