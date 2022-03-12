import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/3/11 16:36
/// desc   : 可持久化保存GetxController状态的Widget基类,用于绑定Controller
/// 由于在TabBarView中切换页面会导致状态重置，从而GetxController销毁
/// 再次切换时需要重新拉取所有信息，体验非常差，因此需要继承AutomaticKeepAliveClientMixin
/// 来达到拦截状态销毁的目的

abstract class GetSaveView<T extends GetxController> extends StatefulWidget{

  const GetSaveView({Key?key}) :super(key: key);

  @protected
  Widget build(BuildContext context);

  final String? tag = null;

  T get controller => GetInstance().find<T>(tag: tag);

  ///Get 局部更新字段
  get updateId => null;

  ///widget生命周期
  get lifecycle => null;

  @override
  State<StatefulWidget> createState() => AutoDisposeState<T>();

}

class AutoDisposeState<S extends GetxController> extends State<GetSaveView>
    with AutomaticKeepAliveClientMixin<GetSaveView> ,WidgetsBindingObserver {

  AutoDisposeState();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<S>(
        id: widget.updateId,
        builder: (controller) {
          return widget.build(context);
        });
  }

  @override
  void initState() {
    super.initState();
    if(widget.lifecycle != null){
      WidgetsBinding.instance?.addObserver(this);
    }
  }

  @override
  void dispose() {
    Get.delete<S>();
    if(widget.lifecycle != null) {
      WidgetsBinding.instance?.removeObserver(this);
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if(widget.lifecycle != null) {
      widget.lifecycle(state);
    }
  }

  @override
  bool get wantKeepAlive => true;
}