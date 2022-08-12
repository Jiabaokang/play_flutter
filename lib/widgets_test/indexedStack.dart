import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:play_flutter/config/Injection_init.dart';
import 'package:play_flutter/res/strings.dart';
import 'package:play_flutter/utils/locale_util.dart';
import 'package:play_flutter/widget/dialog/base_dialog.dart';
import 'package:play_flutter/widget/dialog/dialog_common_style.dart';
import 'package:play_flutter/widget/dialog/dialog_loading.dart';
import 'package:play_flutter/widget/dialog/dialog_share_Infomation.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/3/12 19:57
/// desc   : 验证 相关组件
///
///

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// 初始化配置
  await Injection.init();
  runApp(OKToast(
    child: GetMaterialApp(
      ///国际化-数据来源
      translations: Messages(),

      ///默认语言
      locale: LocaleOptions.getDefault(),

      ///国际化支持-备用语言
      fallbackLocale: const Locale('en', 'US'),

      color: Colors.blueAccent,
      home: Scaffold(
          //body: IndexedStackDemo(),
          // body: BaseDialogDemo(),
          //body: CommonDialogDemo()),
          // body: LoadingDialog(msgContent: "加载中")
          body: ShareDialog(url: "https://www.baidu.com")),
    ),
  ));
}

///验证自己封装CommonDialog
class CommonDialogDemo extends StatelessWidget {
  const CommonDialogDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      title: "这是标题",
      content: "这是一个msg",
      backVisible: true,
      nextVisible: true,
      backText: "取消",
      nextText: "确定",
      backTab: () {
        showToast("点击返回按钮",
            textPadding: const EdgeInsets.all(12),
            position: ToastPosition.bottom);
      },
      nextTab: () {
        showToast("点击确定按钮", textPadding: const EdgeInsets.all(20));
      },
    );
  }
}

///验证自己封装BaseDialog
class BaseDialogDemo extends StatelessWidget {
  const BaseDialogDemo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BaseDialog(
        horizontal: 50,
        shape: 40,
        child: Column(
          children: const [
            Text("data0"),
            Text("data1"),
            Text("data2"),
            Text("data3"),
          ],
        ),
      ),
    );
  }
}

///IndexedStack组件demo
class IndexedStackDemo extends StatefulWidget {
  const IndexedStackDemo({Key? key}) : super(key: key);

  @override
  State<IndexedStackDemo> createState() => _IndexedStackDemoState();
}

class _IndexedStackDemoState extends State<IndexedStackDemo> {
  var _index = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80.0),
      child: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSwitch(),
            Container(
              width: 200,
              height: 100,
              color: Colors.grey.withAlpha(33),
              child: IndexedStack(
                index: _index,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: 80,
                      height: 80,
                      color: Colors.red,
                    ),
                  ),
                  Positioned(
                      bottom: 10,
                      right: 10,
                      child: Container(
                        width: 80,
                        height: 80,
                        color: Colors.blue,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitch() => Switch(
      inactiveTrackColor: Colors.cyan,
      activeColor: Colors.red,
      value: _index == 0,
      onChanged: (v) => setState(() => _index = v ? 0 : 1));
}
