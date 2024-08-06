import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:play_flutter/res_custom/colors.dart';

class ToolBar extends StatefulWidget {
  ///标题文字
  String title;

  ///右侧文字
  String endText;

  ///是否显示右侧
  bool isShowEnd = false;

  ///背景颜色
  Color backgroundColor = Colors.white;

  ///背景颜色
  Color backColor = ColorStyle.color_B8C0D4;

  VoidCallback? backOnTap;

  ToolBar({
    Key? key,
    this.title = '',
    this.endText = '',
    this.isShowEnd = false,
    this.backgroundColor = Colors.white,
    this.backColor = ColorStyle.color_B8C0D4,
    this.backOnTap,
  }) : super(key: key);

  @override
  State<ToolBar> createState() => _ToolBarState();
}

class _ToolBarState extends State<ToolBar> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.backgroundColor,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 12, top: 10, bottom: 8),
              child: InkWell(
                onTap: widget.backOnTap ?? () => Get.back(),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                splashColor: ColorStyle.color_E2E3E8_66,
                highlightColor: ColorStyle.color_E2E3E8_66,
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: Icon(
                    Icons.arrow_back,
                    color: widget.backColor,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 16, right: 24),
                child: Text(
                  widget.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black87, fontSize: 16),
                ),
              ),
            ),
            Container(
              child: Text(
                widget.endText,
                style: const TextStyle(color: ColorStyle.color_B8C0D4, fontSize: 13),
              ),
              padding: const EdgeInsets.all(15),
            ),
          ],
        ),
      ),
    );
  }
}
