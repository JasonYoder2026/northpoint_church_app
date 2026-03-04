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

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        context.push(widget.btnData.route);
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(2, 4),
                blurRadius: 6,
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(widget.btnData.icon, size: 30, color: Colors.white),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  widget.btnData.text,
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
              ),
              const Icon(Icons.chevron_right, color: Colors.white70, size: 24),
            ],
          ),
        ),
      ),
    );
  }
}