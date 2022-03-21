import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:play_flutter/res/r.dart';
import 'package:play_flutter/res/strings.dart';
import 'package:play_flutter/res/style.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/3/19 14:38
/// desc   : 加载中的对话框
class LoadingDialog extends StatelessWidget {
  final String msgContent;

  const LoadingDialog({
    Key? key,
    this.msgContent = StringStyles.loading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      ///界面透明显示
      type: MaterialType.transparency,
      child: Center(
        ///居中并控制子View大小
        child: SizedBox(
          width: 100,
          height: 100,
          child: Container(
            //color: Colors.orange,
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Lottie.asset(R.assetsLottieLoading,
                      width: 60.0, animate: true),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  msgContent,
                  //style: Styles.style_white_14,
                  style: const TextStyle(color: Colors.black),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
