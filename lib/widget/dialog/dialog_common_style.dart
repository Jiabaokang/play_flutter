import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_flutter/base/get/get_extension_method.dart';
import 'package:play_flutter/res_custom/button_style.dart';
import 'package:play_flutter/res_custom/colors.dart';
import 'package:play_flutter/res_custom/style.dart';
import 'package:play_flutter/widget/over_scroll_behavior.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/3/18 09:12
/// desc   : 通用公共弹窗
class CommonDialog extends StatelessWidget {
  final String title;
  final String content;
  final String backText;
  final String nextText;
  final VoidCallback? backTab;
  final VoidCallback? nextTab;
  final bool backVisible;
  final bool nextVisible;

  const CommonDialog({
    Key? key,
    this.title = "",
    this.content = "",
    this.backText = "",
    this.nextText = "",
    this.backTab,
    this.nextTab,
    this.backVisible = true,
    this.nextVisible = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      //type: MaterialType.transparency,
      color: Colors.green,
      child: Center(
        child: ScrollConfiguration(
          //取消滑动组件的滑动阴影
          behavior: OverScrollBehavior(),
          child: ListView(
            //shrinkWrap 可以自适应高度
            shrinkWrap: true,
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  decoration: ShapeDecoration(
                      color: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ///间距
                      Box.vBox15,

                      ///标题
                      Text(
                        title,
                        style: Styles.style_black_18_bold,
                      ),

                      ///内容
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Text(
                          content,
                          style: Styles.style_6A6969_16,
                        ),
                      ),

                      ///分割线
                      DividerStyle.divider1Half,

                      ///确定、取消按钮
                      SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildTextButton(backTab, backText, backVisible),
                            Visibility(
                              visible: backVisible && nextVisible,
                              child: const VerticalDivider(
                                width: 0.5,
                                thickness: 1,
                                color: ColorStyle.colorShadow,
                              ),
                            ),
                            _buildTextButton(nextTab, nextText, nextVisible),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildTextButton(VoidCallback? onTab, String buttonText, bool backVisible) {
    return Visibility(
        visible: backVisible,
        child: Expanded(
          flex: 1,
          child: TextButton(
            style: ButtonStyles.getNoShapeStyle(),
            onPressed: () {
              //getx 扩展函数
              Get.dismiss();
              if (onTab != null) {
                onTab();
              }
            },
            child: Container(
                alignment: Alignment.center, height: 60, child: Text(buttonText, style: Styles.style_black_16)),
          ),
        ));
  }
}
