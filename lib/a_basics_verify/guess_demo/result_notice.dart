import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResultNotice extends StatelessWidget {
  final Color color;
  final String text;
  const ResultNotice({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        color: color,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 54,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
