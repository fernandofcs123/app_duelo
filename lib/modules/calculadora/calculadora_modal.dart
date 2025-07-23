import 'package:app_duelo/modules/calculadora/passarinho_modal.dart';
import 'package:app_duelo/ui/botao_metal_widget.dart';
import 'package:flutter/material.dart';
import 'package:app_duelo/ui/botao_numero_widget.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CalculadoraModal extends StatefulWidget {
  final int hpAtual;
  const CalculadoraModal({super.key, required this.hpAtual});

  @override
  State<CalculadoraModal> createState() => _CalculadoraModalState();
}

class _CalculadoraModalState extends State<CalculadoraModal> {
  String _a = "0";
  String _b = "0";
  String _active = "Atacante";
  bool _flagMetal = false;
  bool _flagHonest = false;
  int _numeroEscolhido = 0;

  int get _resultado {
    int a = int.tryParse(_a) ?? 0;
    int b = int.tryParse(_b) ?? 0;

    if (_flagMetal) {
      a += (b / 2).ceil();
    }

    if (_flagHonest) {
      a += (b).ceil();
    }

    int resultado = a - b;
    return resultado < 0 ? 0 : resultado;
  }

  void _addDigito(String d) {
    setState(() {
      String target = _active == "Atacante" ? _a : _b;
      if (target == "0" && d == "00") return;
      String novo = target == "0" ? d : target + d;
      int? intVal = int.tryParse(novo);
      if (intVal == null) return;
      if (intVal > 99999) novo = "99999";

      if (_active == "Atacante") _a = novo;
      else _b = novo;
    });
  }

  void _dobrarCampo () {
    setState(() {
      if (_active == "Atacante") {
        int valorA = int.tryParse(_a) ?? 0;
        _a = (valorA *2).toString();
      } else {
        int valorB = int.tryParse(_b) ?? 0;
        _b = (valorB * 2).toString();
      }
    });
  }

  void _dividirCampo () {
    setState(() {
      if (_active == "Atacante") {
        int valorA = int.tryParse(_a) ?? 0;
        _a = (valorA /2).ceil().toString();
      } else {
        int valorB = int.tryParse(_b) ?? 0;
        _b = (valorB /2).ceil().toString();
      }
    });
  }

  void _limparCampoAtivo() {
    setState(() {
      if (_active == "Atacante") _a = "0";
      else _b = "0";
    });
  }

  void _alternarCampo(String campo) {
    setState(() {
      _active = campo;
    });
  }

  @override
  Widget build(BuildContext context) {
    final botoes = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "00", "000"];

    return Center(
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Colors.white.withOpacity(0.95),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("HP Atual: ${widget.hpAtual}", style: TextStyle(fontSize: 20)),
              SizedBox(height: 8),
              Text("Resultado: $_resultado",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)
              ),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildCampo("Atacante", _a,),
                  _buildCampo("Defensor", _b,),
                ],

              ),
              SizedBox(height: 20,),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:[ 
                    Expanded(
                      flex: 3,
                      child: Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        alignment: WrapAlignment.center,
                        children: botoes.map((txt) {
                          return SizedBox(
                            width: 55,
                            height: 50,
                            child: BotaoNumeroWidget(
                              onPressed: () => _addDigito(txt),
                              texto: txt,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(width: 6,),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children:[ 
                          BotaoMetalWidget(
                            texto: "Metal",
                            cor: const Color.fromARGB(255, 255, 103, 174),
                            flagAtivo: _flagMetal, 
                            onToggle: () {
                              setState(() {
                                _flagMetal =!_flagMetal;
                              });
                            }
                          ),
                          BotaoMetalWidget(
                            texto: "Honest", 
                            cor: const Color.fromARGB(255, 237, 224, 36),
                            flagAtivo: _flagHonest, 
                            onToggle: () {
                              setState(() {
                                _flagHonest =! _flagHonest;
                              });
                            }
                          ),
                          ElevatedButton(onPressed: _dobrarCampo, child: Text("x2")),
                          ElevatedButton(onPressed: _dividirCampo, child: Text("/2")),
                          ElevatedButton(onPressed: () async {
                            final int? resultado = await showDialog<int>(
                              context: context, 
                              builder: (context) => const PassarinhoModal()
                            );

                            if (resultado != null) {
                              setState(() {
                                _numeroEscolhido = resultado;
                              });
                            }
                          }, 
                            style: ElevatedButton.styleFrom(
                              
                              backgroundColor: _numeroEscolhido != 0
                              ? const Color.fromARGB(255, 171, 210, 242)
                              : null,
                              minimumSize: const Size(60, 40),
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                              alignment: Alignment.center,
                            ),
                            child: _numeroEscolhido == 0
                              ? Icon(LucideIcons.bird, size: 20,)
                              : Text("$_numeroEscolhido",
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18
                                ),
                            )
                          ),
                        ]
                      ),
                    )
                    ],
                ),
              ),

              SizedBox(height: 16,),

              Row(
                children: [
                  // BotaoMetalWidget(
                  //   texto: "Metal",
                  //   flagAtivo: _flagMetal, 
                  //   onToggle: () {
                  //     setState(() {
                  //       _flagMetal =!_flagMetal;
                  //     });
                  //   }
                  // ),
                  
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: _limparCampoAtivo,
                    icon: Icon(Icons.backspace),
                    label: Text("Apagar"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(180, 255, 82, 82),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(), // cancela
                    child: Text("Cancelar"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 2
                    ),
                    onPressed: () => Navigator.of(context).pop(_resultado), // confirma
                    child: Text("Confirmar", style: TextStyle(color: const Color.fromARGB(255, 24, 156, 29), fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            ],
          ),
      )));
  }

  Widget _buildCampo(String label, String valor) {
    final bool ativo = _active == label;
    return GestureDetector(
      onTap: () => _alternarCampo(label),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: ativo ? Colors.blue.withOpacity(0.2) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ativo ? Colors.blue : Colors.black26),
        ),
        child: Column(
          children: [
            Text(label, style: TextStyle(fontSize: 14)),
            const SizedBox(height: 4),
            Text(valor,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
