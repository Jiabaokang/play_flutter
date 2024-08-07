import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StorkWidthSelector extends StatelessWidget {
  final List<double> supportStorkWidths;
  final int activeIndex;
  final Color color;
  final ValueChanged<int> onSelect;

  const StorkWidthSelector({
    super.key,
    required this.supportStorkWidths,
    required this.activeIndex,
    required this.color,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(supportStorkWidths.length, _buildByIndex),
      ),
    );
  }

  Widget _buildByIndex(int index) {
    bool selected = index == activeIndex;
    return GestureDetector(
      onTap: () => onSelect(index),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2.0),
        width: 72,
        height: 18,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0), border: selected ? Border.all(color: Colors.blue) : null),
        child: Container(
          width: 50,
          color: color,
          height: supportStorkWidths[index],
        ),
      ),
    );
  }
}
