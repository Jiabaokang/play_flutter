import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GuessAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onCheck;
  final TextEditingController guessController;

  const GuessAppBar({super.key, required this.onCheck, required this.guessController});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //修改状态栏颜色
      systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark, statusBarColor: Colors.transparent),
      titleSpacing: 0,
      leading: const Icon(
        Icons.menu,
      ),
      actions: [
        IconButton(
          splashRadius: 20,
          onPressed: onCheck,
          icon: const Icon(Icons.run_circle_outlined),
        ),
      ],
      title: TextField(
        keyboardType: TextInputType.number,
        controller: guessController,
        decoration: const InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: "请输入0～99的数字",
            hintStyle: TextStyle(fontSize: 14),
            constraints: BoxConstraints(maxHeight: 35), //输入框高度
            border: UnderlineInputBorder(
                //边框数据
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(6)))),
      ),
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
