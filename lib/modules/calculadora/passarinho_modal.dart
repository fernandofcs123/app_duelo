import 'package:flutter/material.dart';

class PassarinhoModal extends StatelessWidget {
  const PassarinhoModal({super.key});

  @override
  Widget build(BuildContext context) {
    // final botoes = ["0","100","200","300","400","500","600","700","800","900","1000","1100","1200"];
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white.withOpacity(0.95),
      child: SizedBox(
        height: 460,
        width: 240,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
            childAspectRatio: 2.2,
            children: List.generate(13, (index) {
              final valor = index * 100;
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 2,
                  padding: EdgeInsets.zero,
                  backgroundColor: const Color.fromARGB(255, 171, 210, 242),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context, valor);
                },
                child: Text(
                  "$valor",
                  style: const TextStyle(fontSize: 18),
                ),
                
              );
              
              }
              ),
            ),
          ),
        ),
    );
  }
}