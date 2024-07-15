import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaperAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onClear;
  const PaperAppBar({super.key, required this.onClear});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("画板绘制"),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: onClear,
          icon: const Icon(Icons.cleaning_services, color: Colors.black),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
