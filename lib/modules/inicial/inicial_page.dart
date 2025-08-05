import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

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
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //   title: const Text("Duel app"),
      //   centerTitle: true,
      //   backgroundColor: Colors.indigo,
      //   foregroundColor: Colors.white,
      // ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.8,
              child: Image.asset(
                
                'assets/yugi_kaiba.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // const Icon(Icons.sports_kabaddi,size: 100, color: Colors.indigo,),
                  // const Icon(LucideIcons.layoutGrid,size: 100, color: Colors.indigo,),
                  const SizedBox(height: 25,),
                  ElevatedButton(
                    onPressed: _duelo,
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      backgroundColor: Colors.indigo,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    ),
                    child: const Text("Duelo!", style: TextStyle(fontSize: 18, color: Colors.white),),
                  ),
                  const SizedBox(height: 16,),
          
                ],
              ),
            ),
          ),

        ],
        
        
      ),
    );
  }
}