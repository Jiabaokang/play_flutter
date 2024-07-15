import 'package:flutter/cupertino.dart';

class MuyuAssetsImage extends StatelessWidget {
  final String image;
  final VoidCallback onTab;
  const MuyuAssetsImage({super.key, required this.image, required this.onTab});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Center(
          child: Image.asset(
        image,
        height: 200,
      )),
    );
  }
}
