import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:play_flutter/utils/toast_util.dart';

class GuessAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onCheck;
  final TextEditingController guessController;

  const GuessAppBar({super.key, required this.onCheck, required this.guessController});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.indigo,
      //修改状态栏颜色
      systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark, statusBarColor: Colors.transparent),
      titleSpacing: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
        onPressed: () {
          showToast(
            "\n 功能开发中...\n",
            duration: const Duration(milliseconds: 3500),
            position: ToastPosition.center,
            radius: 3.0,
            textStyle: const TextStyle(
              fontSize: 14.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
      actions: [
        IconButton(
          splashRadius: 20,
          onPressed: onCheck,
          icon: const Icon(
            Icons.run_circle_outlined,
            color: Colors.white,
          ),
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
            constraints: BoxConstraints(maxHeight: 46), //输入框高度
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
