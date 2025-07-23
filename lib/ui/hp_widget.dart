import 'package:flutter/material.dart';

class HpWidget extends StatelessWidget {
  final String texto;
  final Color corFundo;
  final double fontSize;
  final FontWeight fontWeight; 

  const HpWidget({
    super.key,
    required this.texto,
    required this.corFundo,
    required this.fontSize,
    this.fontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 0),
      decoration: BoxDecoration(
        color: corFundo,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black54,width: 1),
      ),
      child: Container(
        padding: EdgeInsets.all(8),
        child: Text(
          texto,
          key: ValueKey<String>(texto),
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color:  Colors.black,
            decoration: TextDecoration.none
          ),
        ),
      )
    );
  }
}