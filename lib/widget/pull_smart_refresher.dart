import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:play_flutter/base/get/controller/base_page_controller.dart';
import 'package:play_flutter/res/r.dart';
import 'package:play_flutter/res/strings.dart';
import 'package:play_flutter/res/style.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'over_scroll_behavior.dart';

///刷新状态
enum Refresh {
  ///第一次进入页面
  first,

  ///上拉加载
  pull,

  ///下拉刷新
  down,
}

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/3/3 16:57
/// desc   : 上拉刷新、下拉加载、空白页加载动画
/// 通过在基类BaseGetController中维护上拉刷新、下拉加载、控制器等等状态
/// 不需要暴露给使用者，当然，此方法只能使用Getx框架有效
class RefreshWidget<Controller extends BaseGetPageController>
    extends StatefulWidget {
  final String? tag = null;

  ///获取BaseGetController子类对象，在GetX中，任何BaseGetController都可以通过此方法获取
  ///但是必须是没有dispose的Controller
  Controller get getController => GetInstance().find<Controller>(tag: tag);

  ///是否开启上拉加载
  bool enablePullUp = false;

  ///是否开启下拉刷新
  bool enablePullDown = false;

  ///下拉刷新的回调
   VoidCallback? onRefresh;

  ///上拉刷新的回调
   VoidCallback? onLoadMore;

  ///子类，必须是ListView
   Widget child;

  ///构造方法传参
   RefreshWidget({
    Key? key,
    this.enablePullUp = true,
    this.enablePullDown = true,
    this.onRefresh,
    this.onLoadMore,
    required this.child,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RefreshWidgetState();
}

///混入AutomaticKeepAliveClientMixin，避免界面刷新后状态丢失
class _RefreshWidgetState extends State<RefreshWidget>
    with AutomaticKeepAliveClientMixin {
  ///下拉刷新和上拉加载更多的控制制器，内部维护[RefreshController]
  RefreshController controller = RefreshController(initialRefresh: false);

  @override
  void initState() {
    ///初始化加载控制器
    widget.getController.initPullLoading(controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(
      width: double.infinity,
      height: double.infinity,

      ///重叠布局
      child: Stack(
        alignment: Alignment.center,
        children: [
          ///上拉加载和下拉刷新的控件
          Obx(() => Visibility(
                visible: widget.getController.loadStatus.value == 1,
                child: ScrollConfiguration(
                  //配置滑动的效果
                  behavior: OverScrollBehavior(),
                  child: SmartRefresher(
                    //上拉和下拉刷新的配置
                    controller: controller,
                    enablePullUp: widget.enablePullUp,
                    enablePullDown: widget.enablePullDown,
                    onRefresh: () =>
                        widget.getController.onLoadRefresh(controller),
                    onLoading: () =>
                        widget.getController.onLoadMore(controller),
                    header: _getBuildCustomHeader(),
                    footer: _getBuildCustomFooter(),

                    /// 这个属性Widget需要是ListView
                    child: widget.child,
                  ),
                ),
              )),

          ///加载数据中界面,成功需要隐藏
          Obx(() => Visibility(
                visible: widget.getController.loadStatus.value == 0,
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Lottie.asset(R.assetsLottiePageLoading,
                      width: 200, height: 200, animate: true),
                ),
              )),

          ///加载数据为空的界面
          Obx(() => Visibility(
                visible: widget.getController.loadStatus.value == 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(R.assetsLottieRefreshEmpty,
                        width: 200, animate: true, repeat: false),
                    Text(
                      StringStyles.refreshEmpty.tr,
                      style: Styles.style_B8C0D4_13,
                    )
                  ],
                ),
              )),

          ///加载数据失败的界面
          Obx(() => Visibility(
                visible: widget.getController.loadStatus.value == 3,
                child: Lottie.asset(R.assetsLottiePageLoading,
                    width: 200, height: 200, animate: true),
              )),
        ],
      ),
    );
  }

  ///自定义下拉刷新的头部View
  CustomHeader _getBuildCustomHeader() =>
      CustomHeader(builder: (BuildContext context, RefreshStatus? mode) {
        Widget header;
        if (mode == RefreshStatus.idle) {
          ///下拉时显示
          header = Text(
            StringStyles.refreshHeaderIdle.tr,
            style: Styles.style_B8C0D4_14,
          );
        } else if (mode == RefreshStatus.refreshing) {
          ///加载中
          header = Lottie.asset(R.assetsLottieRefreshHeader,
              width: 100, animate: true);
        } else if (mode == RefreshStatus.failed) {
          ///加载失败
          header = Text(
            StringStyles.refreshHeaderFailed.tr,
            style: Styles.style_B8C0D4_14,
          );
        } else if (mode == RefreshStatus.completed) {
          ///加载成功
          header = Text(
            StringStyles.refreshHeaderSuccess.tr,
            style: Styles.style_B8C0D4_14,
          );
        } else {
          ///超过二层
          header = Text(
            StringStyles.refreshHeaderFreed.tr,
            style: Styles.style_B8C0D4_14,
          );
        }
        return SizedBox(
          height: 64,
          child: Center(child: header),
        );
      });

  ///自定义上拉加载的底部View
  CustomFooter _getBuildCustomFooter() =>
      CustomFooter(builder: (BuildContext context, LoadStatus? mode) {
        Widget footer;
        if (mode == LoadStatus.idle) {
          ///下拉提示
          footer = const Text("pull up load");
        } else if (mode == LoadStatus.loading) {
          ///加载中
          footer = Lottie.asset(R.assetsLottieRefreshFooter,
              width: 200, animate: true);
        } else if (mode == LoadStatus.failed) {
          ///加载失败
          footer = Text(
            StringStyles.refreshError.tr,
            style: Styles.style_B8C0D4_14,
          );
        } else {
          ///无更多数据
          footer = Text(
            StringStyles.refreshNoData.tr,
            style: Styles.style_B8C0D4_14,
          );
        }
        return SizedBox(
          height: 60,
          child: Center(child: footer),
        );
      });

  ///当前Widget是否保存活动懂状态
  @override
  bool get wantKeepAlive => true;
}
