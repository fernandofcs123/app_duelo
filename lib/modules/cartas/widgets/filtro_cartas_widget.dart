import 'package:flutter/material.dart';

class FiltroCartasWidget extends StatefulWidget {
  final VoidCallback onBuscar;
  final VoidCallback onLimpar;

  final ValueChanged<String> onNomeChanged;
  final ValueChanged<String> onEfeitoChanged;
  final ValueChanged<String> onTipoChanged;
  final ValueChanged<bool> onEdisonChanged;

  const FiltroCartasWidget({
    super.key,
    required this.onBuscar,
    required this.onLimpar,
    required this.onNomeChanged,
    required this.onEfeitoChanged,
    required this.onTipoChanged,
    required this.onEdisonChanged,
  });

  @override
  
  State<FiltroCartasWidget> createState() => _FiltroCartasWidgetState();
}


class _FiltroCartasWidgetState extends State<FiltroCartasWidget> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _efeitoController = TextEditingController();
  
  String _tipoSelecionado = 'Todos';
  bool _edison = false;

  void dispose() {
    _nomeController.dispose();
    _efeitoController.dispose();
    super.dispose();
  }
  
  void _limparFiltros() {
    _nomeController.clear();
    _efeitoController.clear();

    setState(() {
      _tipoSelecionado = 'Todos';
      _edison = false;
    });
    widget.onLimpar();
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 4),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nomeController,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      prefixIcon: const Icon(Icons.search, size: 20,),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: widget.onNomeChanged,
                  ),
                ),
                const SizedBox(width: 8),

                Expanded(
                  child: TextField(
                    controller: _efeitoController,
                    decoration: InputDecoration(
                      labelText: 'Efeito',
                      prefixIcon: const Icon(Icons.auto_awesome, size: 20),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: widget.onEfeitoChanged,
                  ),                  
                ),
              ],
            ),

            const SizedBox(height: 8),

            

            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _tipoSelecionado,
                    isDense: true,
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: 'Tipo',
                      prefixIcon: const Icon(
                        Icons.category_outlined,
                        size: 20,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: "Todos",
                        child: Text('Todos'),
                      ),
                      DropdownMenuItem(
                        value: "Monster",
                        child: Text('Monster'),
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
                  ),
                ),
                const SizedBox(width: 8,),
                SizedBox(
                  width: 80,
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Edison',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 0,
                      ),
                    ),
                    child: Checkbox(
                      value: _edison,
                      onChanged: (value) {
                        setState(() {
                          _edison = value ?? false;
                        });
                        widget.onEdisonChanged(_edison);
                      },
                    ),
                  ),
                ),
                IconButton(
                  tooltip: 'Limpar Filtros',
                  onPressed: _limparFiltros, 
                  icon: const Icon(Icons.clear)
                ),
                IconButton.filled(
                  tooltip: 'Buscar',
                  onPressed: widget.onBuscar, 
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}