import 'package:flutter/material.dart';

class BotaoAtualizarWidget extends StatefulWidget {
  final VoidCallback onRefresh;

  const BotaoAtualizarWidget({super.key, required this.onRefresh});

  @override
  State<BotaoAtualizarWidget> createState() => _BotaoAtualizarWidgetState();
}

class _BotaoAtualizarWidgetState extends State<BotaoAtualizarWidget> 
  with SingleTickerProviderStateMixin {
    late AnimationController _controller;

    @override 
    void initState(){
      super.initState();
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1)
      );
    }

    @override
    void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _executarRefresh() {
    _controller.forward(from: 0);
    widget.onRefresh();
  }


  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: IconButton.styleFrom(
        // backgroundColor: const Color.fromARGB(136, 27, 87, 117)
        backgroundColor: const Color.fromARGB(84, 5, 17, 255),
      ),
      onPressed: _executarRefresh, 
      icon: AnimatedBuilder(
        animation: _controller, 
        child: const Icon(Icons.refresh, color: Colors.black),
        builder: (context, child) {
          return Transform.rotate(
            angle: _controller.value * 6.28, 
            child: child
          );
        }
      )
    );
  }
}