import 'package:flutter/material.dart';

class FiltroCartasWidget extends StatelessWidget {
  final VoidCallback onBuscar;
  final ValueChanged<String> onNomeChanged;
  final ValueChanged<String> onTipoChanged;
  final ValueChanged<bool> onEdisonChanged;

  const FiltroCartasWidget({
    super.key,
    required this.onBuscar,
    required this.onNomeChanged,
    required this.onTipoChanged,
    required this.onEdisonChanged,
  });

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
              onChanged: onNomeChanged,
            ),
            const SizedBox(height: 8,),
            DropdownButtonFormField<String>(
              value: "Todos",
              items: const [
                DropdownMenuItem(value: "Todos", child: Text('Todos'),),
                DropdownMenuItem(value: "Monster", child: Text('Monstro'),),
                DropdownMenuItem(value: "Spell Card", child: Text('Spell'),),
                DropdownMenuItem(value: "Trap Card", child: Text('Trap'),),
              ],
              onChanged: (v) => onTipoChanged(v!),
              decoration: const InputDecoration(labelText: 'Tipo'),
            ),
            const SizedBox(height: 8,),
            SwitchListTile(
              title: const Text('Modo Edison'),
              subtitle:
                  const Text('Somente cartas permitidas no formato Edison'),
              value: true,
              onChanged: onEdisonChanged,
            ),
            const SizedBox(height: 8,),
            ElevatedButton.icon(
              onPressed: onBuscar,
              icon: const Icon(Icons.search),
              label: const Text('Buscar'),
            )
          ],
        ),
      ),
    );
  }
}