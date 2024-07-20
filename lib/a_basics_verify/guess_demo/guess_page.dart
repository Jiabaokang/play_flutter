import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:play_flutter/a_basics_verify/guess_demo/guess_app_bar.dart';
import 'package:play_flutter/a_basics_verify/guess_demo/result_notice.dart';
import 'package:play_flutter/a_basics_verify/storage/sp_storage.dart';

class GuessPage extends StatefulWidget {
  const GuessPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _GuessPageState();
  }
}

class _GuessPageState extends State<GuessPage> with AutomaticKeepAliveClientMixin {
  int _value = 0;

  ///是否正在猜测中
  bool _isGuessing = false;

  Random random = Random();
  final TextEditingController _guessController = TextEditingController();

  ///是否大于目标值，null:相等，true:大了,false:小了
  bool? _isBid;

  ///校验数据，检查是否相等
  void _onCheck() {
    print("Check:目标数值=$_value,输入的值=${_guessController.text}");
    int? guessValue = int.tryParse(_guessController.text);
    //游戏未开始，或者输入不是整数，不做处理
    if (!_isGuessing || guessValue == null) return;

    //猜对了
    if (guessValue == _value) {
      setState(() {
        _isBid = null;
        _isGuessing = false;
      });
      return;
    }
    //猜错了
    setState(() {
      _isBid = guessValue > _value;
    });
  }

  /// 生成随机数
  _generateRandomValue() {
    setState(() {
      _isGuessing = true;
      _value = random.nextInt(100);

      ///保存配置信息
      SpStorage.instance.saveGuessConfig(guessing: _isGuessing, value: _value);
    });
  }

  @override
  void dispose() {
    _guessController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    initConfig();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GuessAppBar(
        onCheck: _onCheck,
        guessController: _guessController,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          if (_isBid != null)
            Column(
              children: <Widget>[
                if (_isBid == true) ResultNotice(color: Colors.redAccent, text: "大了"),
                const Spacer(),
                if (_isBid == false) ResultNotice(color: Colors.blue, text: "小了")
              ],
            ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!_isGuessing) Text("点击按钮生成随机数"),
                Text(
                  _isGuessing ? "**" : "$_value",
                  style: const TextStyle(fontSize: 68, color: Colors.blue),
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.generating_tokens_outlined,
          color: Colors.white,
        ),
        backgroundColor: _isGuessing ? Colors.grey : Colors.blue,
        onPressed: _isGuessing ? null : _generateRandomValue,
      ),
    );
  }

  void initConfig() async {
    Map<String, dynamic> config = await SpStorage.instance.readGuessConfig();
    _isGuessing = config['guessing'] ?? false;
    _value = config['value'] ?? 0;
    setState(() {});
  }

  @override
  bool get wantKeepAlive => true;
}
