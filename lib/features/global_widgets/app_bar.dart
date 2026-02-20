import 'package:flutter/material.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final double toolbarHeight;

  const GradientAppBar({
    super.key,
    this.title,
    this.leading,
    this.toolbarHeight = kToolbarHeight,
  });

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null ? Text(title!) : null,
      centerTitle: true,
      toolbarHeight: toolbarHeight,
      leading: leading,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              const Color.fromARGB(255, 149, 224, 105),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.45, 1.0],
          ),
        ),
      ),
    );
  }
}
