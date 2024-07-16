import 'dart:math';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:play_flutter/a_basics_verify/muyu_demo/models/AudioOption.dart';
import 'package:play_flutter/a_basics_verify/muyu_demo/models/Image_option.dart';
import 'package:play_flutter/a_basics_verify/muyu_demo/models/merit_record.dart';
import 'package:play_flutter/a_basics_verify/muyu_demo/page/record_history_page.dart';
import 'package:play_flutter/a_basics_verify/muyu_demo/widgets/animate_text.dart';
import 'package:play_flutter/a_basics_verify/muyu_demo/widgets/count_panel.dart';
import 'package:play_flutter/a_basics_verify/muyu_demo/widgets/muyu_assets_image.dart';
import 'package:play_flutter/a_basics_verify/muyu_demo/widgets/select_audio.dart';
import 'package:play_flutter/a_basics_verify/muyu_demo/widgets/select_image.dart';
import 'package:play_flutter/a_basics_verify/storage/db_storage/db_storage.dart';
import 'package:play_flutter/a_basics_verify/storage/sp_storage.dart';
import 'package:play_flutter/res/assets_res.dart';
import 'package:uuid/uuid.dart';

class MuYuPage extends StatefulWidget {
  const MuYuPage({super.key});

  @override
  State<MuYuPage> createState() => _MuYuPageState();
}

class _MuYuPageState extends State<MuYuPage> with AutomaticKeepAliveClientMixin {
  final Uuid uuid = const Uuid();
  AudioPool? pool;
  final _random = Random();
  int _counter = 0;
  MeritRecord? _curRecord;

  final List<ImageOption> imageOptions = [
    const ImageOption("基础版", AssetsRes.MUYU, 1, 3),
    const ImageOption("尊享版", AssetsRes.MUYU2, 3, 6),
  ];

  final List<AudioOption> audioOptions = [
    const AudioOption("音效1", "muyu_1.mp3"),
    const AudioOption("音效2", "muyu_2.mp3"),
    const AudioOption("音效3", "muyu_3.mp3"),
  ];

  ///当前选择的图片
  int _activeImageIndex = 0;

  ///主页面中的图片和点击时增加的值需要根据 _activeImageIndex 来确定，提供如下方法
  String get activeImage => imageOptions[_activeImageIndex].src;
  int get knockValue {
    int min = imageOptions[_activeImageIndex].min;
    int max = imageOptions[_activeImageIndex].max;
    return min + _random.nextInt(max + 1 - min);
  }

  ///当前选择的音频
  int _activeAudioIndex = 0;
  String get activeAudio => audioOptions[_activeAudioIndex].src;

  ///功德记录
  List<MeritRecord> _records = [];

  @override
  void initState() {
    initAudioPool();
    initConfig();
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
              onTabSwitchAudio: _onTabSwitchAudio,
              onTabSwitchImage: _onTabSwitchImage,
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                MuyuAssetsImage(
                  image: activeImage, //使用选择木鱼的值
                  onTab: _onKnock,
                ),
                if (_curRecord != null) AnimateText(record: _curRecord!)
              ],
            ),
          )
        ],
      ),
    );
  }

  ///敲击木鱼
  void _onKnock() {
    pool?.start();
    setState(() {
      //添加功德记录
      String id = uuid.v4();
      _curRecord = MeritRecord(
        id,
        DateTime.now().millisecondsSinceEpoch,
        knockValue,
        activeImage,
        audioOptions[_activeAudioIndex].name,
      );

      //统计功德值
      _counter += _curRecord!.value;
      //保存配置到本地
      saveConfig();
      //保存到数据库
      DbStorage.instance.meritRecordDao.insert(_curRecord!);
      //添加到记录列表
      _records.add(_curRecord!);
    });
  }

  ///查看历史记录
  void toHistory() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (cex) => RecordHistoryPage(records: _records),
      ),
    );
  }

  ///初始化音频播放器
  void initAudioPool() async {
    pool = await FlameAudio.createPool(activeAudio, maxPlayers: 4);
  }

  ///切换音频
  _onTabSwitchAudio() {
    showCupertinoModalPopup(
        context: context,
        builder: (cex) {
          return AudioOptionPanel(
            audioOptions: audioOptions,
            activeIndex: _activeAudioIndex,
            onSelect: _onSelectAudio,
          );
        });
  }

  ///选择音频的回调
  _onSelectAudio(int index) async {
    Navigator.of(context).pop();
    if (index == _activeAudioIndex) return;
    _activeAudioIndex = index;
    pool = await FlameAudio.createPool(activeAudio, maxPlayers: 1);
    //保存配置到本地
    saveConfig();
  }

  ///选择图片的回调
  _onSelectImage(int index) {
    //关闭弹窗
    Navigator.of(context).pop();
    //如果选择的还是当前样式，不做处理
    if (index == _activeImageIndex) return;
    //更新界面
    setState(() {
      _activeImageIndex = index;
    });
    //保存配置到本地
    saveConfig();
  }

  void saveConfig() {
    SpStorage.instance.saveMuYuConfig(
      counter: _counter,
      activeImageIndex: _activeImageIndex,
      activeAudioIndex: _activeAudioIndex,
    );
  }

  ///切换图片
  _onTabSwitchImage() {
    showCupertinoModalPopup(
        context: context,
        builder: (cex) {
          return ImageOptionPanel(
            imageOptions: imageOptions,
            activeIndex: _activeImageIndex,
            onSelect: _onSelectImage,
          );
        });
  }

  void initConfig() async {
    Map<String, dynamic> config = await SpStorage.instance.readMuYuConfig();

    _counter = config["counter"] ?? 0;
    _activeImageIndex = config["activeImageIndex"] ?? 0;
    _activeAudioIndex = config["activeAudioIndex"] ?? 0;
    _records = await DbStorage.instance.meritRecordDao.query();
    setState(() {});
  }

  @override
  bool get wantKeepAlive => true;
}
