import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '设置',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        centerTitle: true,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [buildColorItem(context)],
      ),
    );
  }

  buildColorItem(BuildContext context) {
    return ListTile(
      onTap: () => _selectColor(context),
      title: const Text('选择主题色'),
      subtitle: const Text('秒表界面的高亮颜色为主题色'),
      trailing: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  _selectColor(BuildContext context) async {
    Color initColor = Theme.of(context).primaryColor;
    final Color newColor = await showColorPickerDialog(
      context,
      initColor,
      title: Text(
        "请选择颜色",
        style: Theme.of(context).textTheme.titleLarge,
      ),
      width: 40,
      height: 40,
      spacing: 0,
      runSpacing: 0,
      borderRadius: 0,
      wheelDiameter: 165,
      enableOpacity: true,
      showColorCode: true,
      colorCodeHasColor: true,
      pickersEnabled: <ColorPickerType, bool>{
        ColorPickerType.wheel: true,
      },
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        copyButton: false,
        pasteButton: false,
        longPressMenu: true,
      ),
      actionButtons: const ColorPickerActionButtons(
        okButton: true,
        closeButton: true,
        dialogActionButtons: false,
      ),
      constraints: const BoxConstraints(minHeight: 480, minWidth: 320, maxWidth: 320),
    );
  }
}
