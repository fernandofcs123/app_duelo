import 'package:flutter/material.dart';

class BotaoNumeroWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String texto;
  final Color? cor;
  

  const BotaoNumeroWidget({
    super.key,
    required this.onPressed,
    required this.texto,
    this.cor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: cor,
        padding: EdgeInsets.symmetric(vertical: 8),
        // textStyle: TextStyle(fontSize: 18),
        minimumSize: Size(50, 50),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.center,
        elevation: 2,
        
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