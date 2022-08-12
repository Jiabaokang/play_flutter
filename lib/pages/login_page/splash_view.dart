import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety_flutter3/flutter_swiper_null_safety_flutter3.dart';
import 'package:get/get.dart';
import 'package:play_flutter/res/r.dart';
import 'package:play_flutter/res/strings.dart';
import 'package:play_flutter/routes/app_routes.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/2/23 11:36
/// desc   : 启动页面

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late final AnimationController _logoController;
  late final Animation<double> _animation;
  late final AnimationController _countdownController;

  @override
  void initState() {
    _logoController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));

    _animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(curve: Curves.easeInOutBack, parent: _logoController));

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _logoController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _logoController.forward();
      }
    });
    _logoController.forward();

    _countdownController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    _countdownController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _countdownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Stack(fit: StackFit.expand, children: <Widget>[
          Image.asset(
              Theme.of(context).brightness == Brightness.light
                  ? R.assetsImagesSplashBg
                  : R.assetsImagesSplashBgDark,
              fit: BoxFit.fill),
          AnimatedFlutterLogo(
            animation: _animation,
          ),
          Align(
            alignment: const Alignment(0.0, 0.7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                AnimatedAndroidLogo(
                  animation: _animation,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SafeArea(
              child: InkWell(
                onTap: () {
                  nextPage(context);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  margin: const EdgeInsets.only(right: 20, bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.black.withAlpha(100),
                  ),
                  child: AnimatedCountdown(
                    context: context,
                    animation: StepTween(begin: 3, end: 0)
                        .animate(_countdownController),
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}

class AnimatedCountdown extends AnimatedWidget {
  final Animation<int> animation;

  AnimatedCountdown({key, required this.animation, context})
      : super(key: key, listenable: animation) {
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        nextPage(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var value = animation.value + 1;
    return Text(
      (value == 0 ? '' : '$value | ') + StringStyles.splashSkip.tr,
      style: const TextStyle(color: Colors.white),
    );
  }
}

class AnimatedFlutterLogo extends AnimatedWidget {
  final Animation<double> animation;

  const AnimatedFlutterLogo({
    Key? key,
    required this.animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      duration: const Duration(milliseconds: 10),
      alignment: Alignment(0, 0.2 + animation.value * 0.3),
      curve: Curves.bounceOut,
      child: Image.asset(
        R.assetsImagesSplashAndroid,
        width: 280,
        height: 120,
      ),
    );
  }
}

class AnimatedAndroidLogo extends AnimatedWidget {
  final Animation<double> animation;

  const AnimatedAndroidLogo({
    Key? key,
    required this.animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Image.asset(
          R.assetsImagesSplashFun,
          width: 140 * animation.value,
          height: 80 * animation.value,
        ),
        Image.asset(
          R.assetsImagesSplashAndroid,
          width: 200 * (1 - animation.value),
          height: 80 * (1 - animation.value),
        ),
      ],
    );
  }
}

void nextPage(context) {
  Get.offAndToNamed(AppRoutes.mainTabNav);
  //Navigator.of(context).pushReplacementNamed(RouteName.main_page);
}

class GuidePage extends StatefulWidget {
  static const List<String> images = <String>[
    'guide_page_1.png',
    'guide_page_2.png',
    'guide_page_3.png',
    'guide_page_4.png'
  ];

  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  int curIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Theme.of(context).primaryColor,
      child: Stack(
        alignment: const Alignment(0, 0.87),
        children: <Widget>[
          Swiper(
              itemBuilder: (ctx, index) => Image.asset(
                    'assets/images/${GuidePage.images[index]}',
                    fit: BoxFit.fill,
                  ),
              itemCount: GuidePage.images.length,
              loop: false,
              onIndexChanged: (index) {
                setState(() {
                  curIndex = index;
                });
              }),
          Offstage(
            offstage: curIndex != GuidePage.images.length - 1,
            child: CupertinoButton(
              color: Theme.of(context).primaryColorDark,
              child: const Text('点我开始'),
              onPressed: () {
                nextPage(context);
              },
            ),
          )
        ],
      ),
    ));
  }
}
