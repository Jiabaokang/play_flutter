import 'package:flutter/cupertino.dart';
import 'package:play_flutter/base/get/controller/base_page_controller.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/3/3 16:57
/// desc   : 上拉刷新、下拉加载、空白页加载动画
/// 通过在基类BaseGetController中维护上拉刷新、下拉加载、控制器等等状态
/// 不需要暴露给使用者，当然，此方法只能使用Getx框架有效

///刷新状态
enum Refresh{
  ///第一次进入页面
  first,
  ///上拉加载
  pull,
  ///下拉刷新
  down,
}

class RefreshWidget<Controller extends BaseGetPageController> extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}