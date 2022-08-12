import 'package:get/get.dart';
import 'package:play_flutter/base/get/getx_controller_inject.dart';
import 'package:play_flutter/widget/pull_smart_refresher.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';


/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/3/3 16:11
/// desc   : 分页专用，如果页面中有分页加载，请使用此BaseGetPageController
/// 如果没有分页，请使用BaseGetController
/// 此页面暂时不对数据进行处理，不放置List在此处，因为当前已经很简洁了，不需要绑定[RefreshWidget]进行节省代码

class BaseGetPageController extends BaseGetController {


  ///加载状态: 0加载中 1加载成功 2数据为空 3加载失败
  var loadStatus = 0.obs;

  ///当前页数
  var page = 1;

  ///是否第一次加载
  var isInit = true;

  ///界面刷新控制器
  var refreshController;

  ///界面显示加载中
  void showLoading() {
    loadStatus.value = 0;
  }

  ///界面显示加载成功
  void showSuccess(List suc) {
    loadStatus.value = suc.isNotEmpty ? 1 : 2;
  }

  ///界面显示加载失败
  void showFailed() {
    loadStatus.value = 3;
  }

  ///预留初次加载，注意只供上拉下拉使用
  initPullLoading(RefreshController controller) {
    if (isInit) {
      refreshController = controller;
      requestData(controller);
    }
  }

  ///下拉刷新
  onLoadRefresh(RefreshController controller) {
    page = 1;
    requestData(controller, refresh: Refresh.pull);
  }

  ///上拉加载更多
  onLoadMore(RefreshController controller) {
    ++page;
    requestData(controller, refresh: Refresh.down);
  }

  ///网络请求在此处进行，不用在重复进行上拉下拉的处理
  void requestData(RefreshController controller, {Refresh refresh = Refresh.first}) {}
}
