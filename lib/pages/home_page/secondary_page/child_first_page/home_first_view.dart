import 'package:flutter/material.dart';
import 'package:play_flutter/base/get/get_save_state_view.dart';
import 'package:play_flutter/widget/pull_smart_refresher.dart';
import 'home_first_logic.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/3/15 23:20
/// desc   : 首页
class HomeFirstPage extends GetSaveView<HomeFirstLogic> {
  const HomeFirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            Expanded(
                child: Container(
              color: Colors.white,
              child: RefreshWidget<HomeFirstLogic>(
                child: ListView.builder(itemBuilder: (context, index) {

                  return Text("data");
                }),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
