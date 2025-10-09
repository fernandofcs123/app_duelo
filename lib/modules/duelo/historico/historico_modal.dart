import 'package:flutter/material.dart';

class HistoricoModal extends StatelessWidget {
  final List<Map<String, dynamic>> historico; // lista de ações (HP1 = -1000 etc)
  final VoidCallback onReset; // callback pra limpar tudo

  const HistoricoModal({
    super.key,
    required this.historico,
    required this.onReset,
  });

  Color _getCorTexto(Map<String, dynamic> item) {
    if (item['hp'] == 'HP1') {
      return item['tipo'] == '+'
        ? Colors.blueAccent.shade100
        : Colors.blue.shade900;
    } else {
      return item['tipo'] == '+'
        ? Colors.redAccent.shade100
        : Colors.red.shade900;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.white.withOpacity(0.95),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Histórico",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: historico.length,
                itemBuilder: (context, index) {
                  final item = historico[index];
                  final cor = _getCorTexto(item);
                  final texto =
                      "${item['hp']}   ${item['tipo']} ${item['valor']}  (${item['antes']} → ${item['depois']})";

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      texto,
                      style: TextStyle(
                        fontSize: 16,
                        color: cor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
