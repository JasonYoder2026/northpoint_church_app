import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GridButtonData {
  final IconData icon;
  final String text;
  final String route;

  GridButtonData({required this.icon, required this.text, required this.route});
}

class GridButton extends StatefulWidget {
  final GridButtonData btnData;

  const GridButton({super.key, required this.btnData});

  @override
  State<GridButton> createState() => _GridButtonState();
}

class _GridButtonState extends State<GridButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final gradient = LinearGradient(
      colors: [
        Theme.of(context).colorScheme.primary.withOpacity(0.9),
        Theme.of(context).colorScheme.inversePrimary,
      ],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      stops: [0.60, 0.95],
    );

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        context.push(widget.btnData.route);
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
        child: Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: const Offset(2, 4),
                blurRadius: 6,
              ),
              BoxShadow(
                color: Colors.white.withOpacity(0.2),
                offset: const Offset(-2, -2),
                blurRadius: 6,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.btnData.icon, size: 38, color: Colors.white),
              const SizedBox(height: 8),
              Text(
                widget.btnData.text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 2,
                      color: Colors.black38,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
