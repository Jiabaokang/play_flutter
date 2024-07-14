import 'dart:math';

import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:play_flutter/a_basics_verify/muyu/animate_text.dart';
import 'package:play_flutter/a_basics_verify/muyu/muyu_assets_image.dart';

import '../../res/assets_res.dart';
import 'count_panel.dart';

class MuYuPage extends StatefulWidget {
  const MuYuPage({super.key});

  @override
  State<MuYuPage> createState() => _MuYuPageState();
}

class _MuYuPageState extends State<MuYuPage> {
  AudioPool? pool;
  final _random = Random();
  int _counter = 0;
  int _curValue = 0;

  void _onKnock() {
    pool?.start();
    setState(() {
      _curValue = 1 + _random.nextInt(3);
      _counter += _curValue;
    });
  }

  @override
  void initState() {
    initAudioPool();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        title: const Text("电子木鱼"),
        actions: [
          IconButton(
            onPressed: toHistory,
            icon: const Icon(Icons.history),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: CountPanel(
              count: _counter,
              onTabSwitchAudio: () {},
              onTabSwitchImage: () {},
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                MuyuAssetsImage(
                  image: AssetsRes.MUYU,
                  onTab: _onKnock,
                ),
                if (_curValue != 0) AnimateText(text: "功德:+$_curValue")
              ],
            ),
          )
        ],
      ),
    );
  }

  void toHistory() {}

  void initAudioPool() async {
    pool = await FlameAudio.createPool(AssetsRes.MUYU_1, maxPlayers: 4);
  }
}
