import 'package:flutter/material.dart';

class FiltroCartasWidget extends StatefulWidget {
  final VoidCallback onBuscar;
  final VoidCallback onLimpar;

  final ValueChanged<String> onNomeChanged;
  final ValueChanged<String> onEfeitoChanged;
  final ValueChanged<String> onTipoChanged;

  const FiltroCartasWidget({
    super.key,
    required this.onBuscar,
    required this.onLimpar,
    required this.onNomeChanged,
    required this.onEfeitoChanged,
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
                labelText: "Procurar por nome",
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: widget.onNomeChanged,
            ),

            const SizedBox(height: 8),

            TextField(
              decoration: const InputDecoration(
                labelText: "Procurar por efeito",
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: widget.onEfeitoChanged,
            ),

            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: _tipoSelecionado,
              items: const [
                DropdownMenuItem(
                  value: "Todos",
                  child: Text('Todos'),
                ),
                DropdownMenuItem(
                  value: "Monster",
                  child: Text('Monstro'),
                ),
                DropdownMenuItem(
                  value: "Spell Card",
                  child: Text('Spell'),
                ),
                DropdownMenuItem(
                  value: "Trap Card",
                  child: Text('Trap'),
                ),
              ],
              onChanged: (v) {
                if (v == null) return;

                setState(() {
                  _tipoSelecionado = v;
                });

                widget.onTipoChanged(v);
              },
              decoration: const InputDecoration(
                labelText: 'Tipo',
              ),
            ),

            const SizedBox(height: 12),

            // BOTÕES
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: widget.onLimpar,
                  icon: const Icon(Icons.clear),
                  label: const Text('Limpar filtros'),
                ),

                const SizedBox(width: 8),

                ElevatedButton.icon(
                  onPressed: widget.onBuscar,
                  icon: const Icon(Icons.search),
                  label: const Text('Buscar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}