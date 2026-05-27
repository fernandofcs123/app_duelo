import 'package:flutter/material.dart';

class FiltroCartasWidget extends StatefulWidget {
  final VoidCallback onBuscar;
  final ValueChanged<String> onNomeChanged;
  final ValueChanged<String> onTipoChanged;

  const FiltroCartasWidget({
    super.key,
    required this.onBuscar,
    required this.onNomeChanged,
    required this.onTipoChanged,
  });

  @override
  State<FiltroCartasWidget> createState() => _FiltroCartasWidgetState();
}

class _FiltroCartasWidgetState extends State<FiltroCartasWidget> {
  String _tipoSelecionado = 'Todos';

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: "Nome da carta",
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: widget.onNomeChanged,
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _tipoSelecionado,
              items: const [
                DropdownMenuItem(value: "Todos", child: Text('Todos')),
                DropdownMenuItem(value: "Monster", child: Text('Monstro')),
                DropdownMenuItem(value: "Spell Card", child: Text('Spell')),
                DropdownMenuItem(value: "Trap Card", child: Text('Trap')),
              ],
              onChanged: (v) {
                if (v == null) return;
                setState(() {
                  _tipoSelecionado = v;
                });
                widget.onTipoChanged(v);
              },
              decoration: const InputDecoration(labelText: 'Tipo'),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: widget.onBuscar,
              icon: const Icon(Icons.search),
              label: const Text('Buscar'),
            ),
          ],
        ),
      ),
    );
  }
}
