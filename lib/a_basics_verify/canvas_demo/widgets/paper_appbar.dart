import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaperAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onClear;
  final VoidCallback? onBack;
  final VoidCallback? onRevocation;
  const PaperAppBar({
    super.key,
    required this.onClear,
    this.onBack,
    this.onRevocation,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("画板绘制"),
      centerTitle: true,
      leading: BackUpButtons(onBack: onBack, onRevocation: onRevocation),
      leadingWidth: 100,
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

class BackUpButtons extends StatelessWidget {
  final VoidCallback? onBack;
  final VoidCallback? onRevocation;
  const BackUpButtons({
    super.key,
    required this.onBack,
    required this.onRevocation,
  });

  @override
  Widget build(BuildContext context) {
    BoxConstraints constraints = const BoxConstraints(minWidth: 32, minHeight: 32);
    Color backColor = onBack == null ? Colors.grey : Colors.black;
    Color revocationColor = onRevocation == null ? Colors.grey : Colors.black;
    return Center(
      child: Wrap(
        children: [
          // scaleX: -1 会改变X轴方向
          Transform.scale(
            scaleX: -1,
            child: IconButton(
              constraints: constraints,
              onPressed: onBack,
              icon: Icon(
                Icons.next_plan_outlined,
                color: backColor,
              ),
            ),
          ),
          IconButton(
            splashRadius: 20,
            constraints: constraints,
            onPressed: onRevocation,
            icon: Icon(
              Icons.next_plan_outlined,
              color: revocationColor,
            ),
          ),
        ],
      ),
    );
  }
}
