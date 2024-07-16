import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final VoidCallback onConfirm;

  const ConfirmDialog({
    super.key,
    required this.title,
    required this.content,
    this.confirmText = "删除",
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTitle(),
            _buildMessage(),
            _buildButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.warning_amber_rounded, color: Colors.orange),
        const SizedBox(width: 10.0),
        Text(title, style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildMessage() => Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 15),
        child: Text(
          content,
          style: const TextStyle(fontSize: 14.0),
        ),
      );

  Widget _buildButtons(BuildContext context) => Row(
        children: [
          const Spacer(),
          OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              "取消",
              style: TextStyle(color: Colors.grey),
            ),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(80, 35),
              shape: const StadiumBorder(),
              elevation: 0,
              padding: EdgeInsets.zero,
            ),
          ),
          const SizedBox(width: 10.0),
          ElevatedButton(
            onPressed: onConfirm,
            child: Text(confirmText),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(80, 35),
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: const StadiumBorder(),
              elevation: 0,
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      );
}
