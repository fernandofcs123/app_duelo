import 'package:flutter/material.dart';

class InicialPage extends StatefulWidget {
  const InicialPage({super.key});

  @override
  State<InicialPage> createState() => _InicialPageState();
}

class _InicialPageState extends State<InicialPage> {
  
  void _duelo() {
    Navigator.of(context).pushNamed("/duelo");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Duel app"),
              SizedBox(height: 100,),
              ElevatedButton(onPressed: _duelo, child: Text("Duelo!")),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: (){}, child: Text("Botao 1")),
            ],
          ),
        ),
      )
    );
  }
}