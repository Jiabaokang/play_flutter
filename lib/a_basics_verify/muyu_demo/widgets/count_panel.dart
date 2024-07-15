import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountPanel extends StatelessWidget {
  final int count;
  final VoidCallback onTabSwitchAudio;
  final VoidCallback onTabSwitchImage;

  const CountPanel({
    super.key,
    required this.count,
    required this.onTabSwitchAudio,
    required this.onTabSwitchImage,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Text(
            "功德数:$count",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Wrap(
            spacing: 8,
            direction: Axis.vertical,
            children: [
              ElevatedButton(onPressed: onTabSwitchAudio, child: Icon(Icons.music_note_outlined)),
              ElevatedButton(onPressed: onTabSwitchImage, child: Icon(Icons.image)),
            ],
          ),
        )
      ],
    );
    ;
  }
}
