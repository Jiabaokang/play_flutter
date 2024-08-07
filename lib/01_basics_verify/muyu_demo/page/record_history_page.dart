import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:play_flutter/01_basics_verify/muyu_demo/models/merit_record.dart';

DateFormat format = DateFormat('yyyy年MM月dd日 HH:mm:ss');

class RecordHistoryPage extends StatelessWidget {
  final List<MeritRecord> records;

  const RecordHistoryPage({super.key, required this.records});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: ListView.builder(
        itemBuilder: _itemBuilder,
        itemCount: records.length,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() => AppBar(
        title: const Text(
          "功德记录",
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      );

  Widget? _itemBuilder(BuildContext context, int index) {
    MeritRecord merit = records[index];
    String date = format.format(DateTime.fromMillisecondsSinceEpoch(merit.timestamp));
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        backgroundImage: AssetImage(merit.image),
      ),
      title: Text("功德 +${merit.value}"),
      subtitle: Text(merit.audio),
      trailing: Text(
        date,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
    );
  }
}
