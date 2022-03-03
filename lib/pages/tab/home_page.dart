

import 'package:flutter/material.dart';
import '../../generated/l10n.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/2/23 11:36
/// desc   : 主界面
///

class HomePage extends StatelessWidget {

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildContainer();
  }

  Padding buildContainer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          color: Color(0xff4b1717),
        ),
      ),
    );
  }


}
