import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorSelector extends StatelessWidget {
  final List<Color> supportColors;
  final int activeColorIndex;
  final ValueChanged<int> onSelect;

  const ColorSelector({
    super.key,
    required this.supportColors,
    required this.activeColorIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Wrap(
        spacing: 4.0,
        runSpacing: 8.0,
        children: List.generate(supportColors.length, _buildByIndex),
      ),
    );
  }

  Widget _buildByIndex(int index) {
    bool select = index == activeColorIndex;
    return GestureDetector(
      onTap: () => onSelect(index),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(2),
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: select ? Border.all(color: Colors.blue, width: 2) : null,
        ),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: supportColors[index],
          ),
        ),
      ),
    );
  }
}
