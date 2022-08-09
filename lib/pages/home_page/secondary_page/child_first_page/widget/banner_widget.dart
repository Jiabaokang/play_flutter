import 'dart:async';
import 'package:flutter/material.dart';
import 'package:play_flutter/model/home_model/banner_bean.dart';
import 'package:play_flutter/res/colors.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/8/8 16:42
/// desc   : 首页显示版本
class BannerWidget extends StatefulWidget {
  /// Banner数据
  final List<BannerBean> bannerList;

  /// Banner高度
  final double height;

  /// Banner点击位置
  final ValueChanged<int> onTab;

  /// Banner滑动曲线
  final Curve curves;

  ///构造方法传值
  const BannerWidget({
    Key? key,
    required this.bannerList,
    required this.onTab,
    this.height = 200,
    this.curves = Curves.linear,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BannerState();
}

class _BannerState extends State<BannerWidget> {
  late PageController _pageController;
  late int _curIndex;
  Timer? _time;

  @override
  void initState() {
    super.initState();
    _curIndex = widget.bannerList.length * 5;
    _pageController = PageController(initialPage: _curIndex);
    initTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [_buildPageView(), _buildIndicator()],
    );
  }

  ///初始化定时任务
  void initTimer() {}

  Widget _buildPageView() {
    if (widget.bannerList.isEmpty) {
      return const SizedBox();
    }
    var length = widget.bannerList.length;
    return SizedBox(
      height: widget.height,
      child: PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          physics: const PageScrollPhysics(parent: BouncingScrollPhysics()),
          onPageChanged: (index) {
            setState(() {
              _curIndex = index;
              if (index == 0) {
                _curIndex = 0;
                _onChangePage();
              }
            });
          },
          //构建BannerItem
          itemBuilder: (context, index) {
            var itemBean = widget.bannerList[index % length];
            return GestureDetector(
              //手指按下事件
              onTapDown: (details) {
                _cancelTimer();
              },
              //手指点击事件
              onTap: () {
                widget.onTab(index % length);
              },

              //显示的内容
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: itemBean.isAssets
                      ? Container(
                          color: ColorStyle.color_FBE240,
                          child: Image.asset(itemBean.imagePath))
                      : Image.network(itemBean.imagePath, fit: BoxFit.fill),
                ),
              ),
            );
          }),
    );
  }

  ///banner指示器
  Widget _buildIndicator() {
    if (widget.bannerList.isEmpty) {
      return const SizedBox();
    }
    var length = widget.bannerList.length;
    return Positioned(
      bottom: 10,
      child: Row(
        children: widget.bannerList
            .map((e) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: ClipOval(
                    child: Container(
                        width: 7,
                        height: 7,
                        color: e == widget.bannerList[_curIndex % length]
                            ? Colors.white
                            : Colors.grey),
                  ),
                ))
            .toList(),
      ),
    );
  }

  ///切换页面,并更新小圆点
  void _onChangePage() {
    Timer(const Duration(milliseconds: 300), () {
      _pageController.jumpToPage(_curIndex);
    });
  }

  ///取消定时器即使
  void _cancelTimer() {
    if (_time != null) {
      _time?.cancel();
      _time = null;
      //重新开始计时
      initTimer();
    }
  }
}
