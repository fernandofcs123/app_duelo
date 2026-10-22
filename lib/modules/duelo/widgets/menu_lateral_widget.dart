import 'package:flutter/material.dart';

class MenuLateralWidget extends StatelessWidget {
  final bool aberto;
  final VoidCallback onAlternar;
  final VoidCallback onFechar;
  final VoidCallback onListaCartas;
  final VoidCallback onMeusDecks;
  final VoidCallback onMinhasCartas;

  const MenuLateralWidget({
    super.key,
    required this.aberto,
    required this.onAlternar,
    required this.onFechar,
    required this.onListaCartas,
    required this.onMeusDecks,
    required this.onMinhasCartas,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (aberto)
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: onFechar,
              child: const SizedBox.expand(),
          ),
        ),
      
      SafeArea(
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (aberto) ...[
                  _itemMenu(
                    icone: Icons.style_outlined,
                    titulo: 'Todas as cartas',
                    onTap: onListaCartas,
                  ),
                  const SizedBox(height: 12),
                  _itemMenu(
                    icone: Icons.collections_bookmark_outlined,
                    titulo: 'Minhas cartas',
                    onTap: onMinhasCartas,
                  ),
                  const SizedBox(height: 12),
                  _itemMenu(
                    icone: Icons.layers_outlined,
                    titulo: 'Meus decks',
                    onTap: onMeusDecks,
                  ),
                  const SizedBox(height: 12),
                ],
                _botaoMenu(),
              ],
            ),
          ),
        ),
      ),
    )
      ],
    );
  }

  Widget _botaoMenu() {
    return Material(
      color: const Color(0xFF263957),
      shape: const CircleBorder(),
      elevation: 4,
      child: InkWell(
        onTap: aberto ? onFechar : onAlternar,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 56,
          height: 56,
          child: Icon(
            aberto ? Icons.close : Icons.menu,
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
    );
  }

  Widget _itemMenu({
    required IconData icone,
    required String titulo,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(28),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              color: const Color(0xFF263957),
              shape: const CircleBorder(),
              elevation: 3,
              child: SizedBox(
                width: 56,
                height: 56,
                child: Icon(
                  icone,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 11,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.90),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.10),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                titulo,
                style: const TextStyle(
                  color: Color(0xFF263957),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  shadows: [
                    Shadow(
                      color: Colors.white54,
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
