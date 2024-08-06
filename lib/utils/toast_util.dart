import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/4/5 23:50
/// desc   : Toast提示工具类
class ToastUtil {
  static show(String msg) {
    showToast(
      msg,
      duration: const Duration(milliseconds: 3500),
      position: ToastPosition.bottom,
      backgroundColor: Colors.black.withOpacity(0.8),
      radius: 3.0,
      textStyle: const TextStyle(fontSize: 16.0, color: Colors.white),
    );
  }
}
