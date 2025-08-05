import 'package:app_duelo/modules/calculadora/calculadora_modal.dart';
import 'package:app_duelo/modules/duelo/historico/historico_modal.dart';
import 'package:app_duelo/ui/botao_atualizar_widget.dart';
import 'package:app_duelo/ui/botao_numero_widget.dart';
import 'package:app_duelo/ui/cores.dart';
import 'package:flutter/material.dart';

class DueloPage extends StatefulWidget {
  
  const DueloPage({super.key});

  @override
  State<DueloPage> createState() => _DueloPageState();
}

class _DueloPageState extends State<DueloPage> {
  int hp1 = 8000;
  int hp2 = 8000;
  String valorDigitado ="0";
  int hpSelecionado = 1;

  


  void _abrirCalculadora(BuildContext context) async {
    final int hpAtual = hpSelecionado == 1 ? hp1 : hp2;
    print(hpAtual);

    final int? resultado = await showDialog<int>(
      context: context,
      // barrierDismissible: false,
      builder: (_) => CalculadoraModal(hpAtual: hpAtual, player: hpSelecionado),
    );

    if (resultado != null) {
      setState(() {
        if (hpSelecionado ==1){
          hp1 = (hp1 - resultado).clamp(0, double.infinity).toInt();
        } else {
          hp2 = (hp2 - resultado).clamp(0, double.infinity).toInt();
        }
      });
    }

  }

  void adicionarDigito (String digito){
    setState(() {
      if (valorDigitado == "0" && (digito == '00' || digito == '000')){
        return;

      }
      String novoValor = valorDigitado == '0' ? digito : valorDigitado + digito;

      int? valorInt = int.tryParse(novoValor);

      if (valorInt ==null) {
        return;
      }

      if (valorInt > 99999) {
        valorDigitado = '99999';
        return;
      }

      valorDigitado = novoValor;
    });
  }

  void aplicarOperacao(bool somar) {
    int valor = int.tryParse(valorDigitado) ?? 0;
    setState(() {
      if (somar) {
        if (hpSelecionado ==1){
          hp1 += valor;
        } else {
          hp2 += valor;
        }
      } else {
        if (hpSelecionado == 1){
          hp1 = (hp1 -valor).clamp(0, double.infinity).toInt();
        } else {
          hp2 = (hp2 -valor).clamp(0, double.infinity).toInt();
        }
      }
      valorDigitado ="0";
    });
  }

  void dividir(){
    setState(() {
      if (hpSelecionado ==1){
        hp1 = (hp1 /2).ceil();
      } else {
        hp2 = (hp2 /2).ceil();
      }
    });
  }

  void selecionarHp(int numero){
    setState(() {
      hpSelecionado = numero;
    });
  }

  void limparValorDigitado(){
    setState(() {
      valorDigitado ="0";
    });
  }

  void resetarHps(){
    setState(() {
      hp1 = 8000;
      hp2 = 8000;
    });
  }

  void _historico(){
    showDialog(context: context, builder: (_) => HistoricoModal());
  }
  

  final List<Map<String, dynamic>> botoes =[];

  

  @override

  void initState() {
    super.initState();
    botoes.addAll([
      {'texto':'1','acao':()=> adicionarDigito('1')},
      {'texto':'2','acao':()=> adicionarDigito('2')},
      {'texto':'3','acao':()=> adicionarDigito('3')},
      {'texto':'4','acao':()=> adicionarDigito('4')},
      {'texto':'5','acao':()=> adicionarDigito('5')},
      {'texto':'6','acao':()=> adicionarDigito('6')},
      {'texto':'7','acao':()=> adicionarDigito('7')},
      {'texto':'8','acao':()=> adicionarDigito('8')},
      {'texto':'9','acao':()=> adicionarDigito('9')},
      {'texto':'0','acao':()=> adicionarDigito('0')},
      {'texto':'00','acao':()=> adicionarDigito('00')},
      {'texto':'000','acao':()=> adicionarDigito('000')},
    ]);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      
      color: Cores.corFundo,
      width: double.infinity,
      height: double.infinity,
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 155, 165, 243),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black54,width: 1),
                      ),
                      child: GestureDetector(
                        onTap: () => selecionarHp(1),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: hpSelecionado == 1 ? const Color.fromARGB(255, 12, 117, 236).withOpacity(0.2) : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 300),
                            transitionBuilder: (Widget child, Animation<double> animation) {
                              return ScaleTransition(scale: animation, child: child);
                            },
                            child: Text(
                              "$hp1",
                              key: ValueKey<int>(hp1),
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: hpSelecionado == 1 ? FontWeight.bold : FontWeight.normal,
                                color:  Colors.black,
                                decoration: TextDecoration.none
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 238, 142, 134),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black54,width: 1),
                      ),
                      child: GestureDetector(
                        onTap: () => selecionarHp(2),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: hpSelecionado == 2 ? const Color.fromARGB(255, 219, 228, 238).withOpacity(0.2) : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 300),
                            transitionBuilder: (Widget child, Animation<double> animation) {
                              return ScaleTransition(scale: animation, child: child);
                            },
                            child: Text(
                              "$hp2",
                              key: ValueKey<int>(hp2),
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: hpSelecionado == 2 ? FontWeight.bold : FontWeight.normal,
                                color:  Colors.black,
                                decoration: TextDecoration.none
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
      
                const SizedBox(height: 20,),
      
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 216, 182, 119),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black54, width: 1),
                  ),
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 80),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                    child: Text(
                      valorDigitado,
                      key: ValueKey<String>(valorDigitado), // 👈 importante para animar mudança
                      style: TextStyle(
                        fontSize: 40,
                        color: const Color.fromARGB(255, 0, 0, 0),
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10,),
                
                //===================================================================================== TECLADO NUMERICO ============================

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Parte dos números (3 colunas)
                    Expanded(
                      flex: 3,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          // Calcula largura disponível do Expanded (sem considerar espaçamento)
                          // final larguraTotal = constraints.maxWidth;
                          // Espaçamento entre botões no Wrap (8 * 2 espaços entre 3 botões)
                          // final espacamentoTotal = 8 * 2;
                          // Largura disponível por botão
                          // final larguraBotao = (larguraTotal - espacamentoTotal) / 3;

                          return Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: botoes.map((botao) {
                              return SizedBox(
                                width: 80,
                                height: 70,
                                child: BotaoNumeroWidget(
                                  onPressed: botao['acao'], 
                                  texto: botao['texto'],
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Coluna da direita com botões lógicos (2 colunas)
                    SizedBox(
                      width: 72,
                      // flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: BotaoNumeroWidget(
                              texto: "C",
                              cor: const Color.fromARGB(255, 216, 182, 119),
                              onPressed: limparValorDigitado,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: BotaoNumeroWidget(
                              texto: "+",
                              cor: const Color.fromARGB(133, 124, 221, 132),
                              onPressed: () => aplicarOperacao(true),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: BotaoNumeroWidget(
                              texto: "-",
                              cor: const Color.fromARGB(182, 250, 111, 111),
                              onPressed: () => aplicarOperacao(false),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: BotaoNumeroWidget(
                              texto: "÷2",
                              cor: Cores.metalmorph,
                              onPressed: dividir,
                            ),
                          ),
                          const SizedBox(height: 10),
                          
                          // SizedBox(
                          //   width: double.infinity,
                          //   height: 60,
                          //   child: BotaoNumeroWidget(
                          //     texto: "R",
                          //     onPressed: resetarHps,
                          //   ),
                          // ),
                          SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: BotaoAtualizarWidget(onRefresh: resetarHps)
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [ 
                    ElevatedButton.icon(
                      icon: const Icon(Icons.calculate, size: 22, color: Colors.white,),
                      onPressed: ()=> _abrirCalculadora(context), 
                      label: Text("Calculadora", 
                      style: TextStyle(
                        fontSize: 19, 
                        fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        elevation: 4,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)
                        )
                      ),
                  ),
                  ElevatedButton(onPressed: _historico, child: Text("Historico"))
                  ]
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}