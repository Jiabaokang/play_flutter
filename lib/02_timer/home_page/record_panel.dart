import 'package:flutter/material.dart';
import 'package:play_flutter/02_timer/home_page/model/time_record.dart';
import 'package:play_flutter/res/font_res.dart';

class RecordPanel extends StatelessWidget {
  final List<TimeRecord> records;
  const RecordPanel({super.key, required this.records});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: DefaultTextStyle(
        style: const TextStyle(fontFamily: FontRes.ICONFONT, color: Colors.black),
        child: ListView.builder(
          itemBuilder: _buildItemByIndex,
          itemCount: records.length,
        ),
      ),
    );
  }

  final EdgeInsets itemPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 4);

  Widget _buildItemByIndex(BuildContext context, int index) {
    int reverseIndex = records.length - 1 - index;
    bool lightIndex = reverseIndex == records.length - 1;
    Color themeColor = Theme.of(context).primaryColor;
    Color? indexColor = lightIndex ? themeColor : null;

    return Row(
      children: [
        Padding(
          padding: itemPadding,
          child: Text(
            reverseIndex.toString().padLeft(2, "0"),
            style: TextStyle(color: indexColor),
          ),
        ),
        Text(durationToStr(records[reverseIndex].record)),
        const Spacer(),
        Padding(
          padding: itemPadding,
          child: Text("+${durationToStr(records[reverseIndex].addition)}"),
        ),
      ],
    );
  }

  String durationToStr(Duration duration) {
    int minus = duration.inMinutes % 60;
    int second = duration.inSeconds % 60;
    int millisecond = duration.inMilliseconds % 1000;
    String commonStr = "${minus.toString().padLeft(2, "0")}:${second.toString().padLeft(2, "0")}";
    String highlightStr = ".${(millisecond ~/ 10).toString().padLeft(2, "0")}";
    return commonStr + highlightStr;
  }
}
