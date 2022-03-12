import 'package:flutter/material.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/3/12 19:57
/// desc   :
///
void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: IndexedStackDemo(),
    ),
  ));
}

class IndexedStackDemo extends StatefulWidget {
  const IndexedStackDemo({Key? key}) : super(key: key);

  @override
  State<IndexedStackDemo> createState() => _IndexedStackDemoState();
}

class _IndexedStackDemoState extends State<IndexedStackDemo> {
  var _index = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80.0),
      child: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSwitch(),
            Container(
              width: 200,
              height: 100,
              color: Colors.grey.withAlpha(33),
              child: IndexedStack(
                index: _index,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: 80,
                      height: 80,
                      color: Colors.red,
                    ),
                  ),
                  Positioned(
                      bottom: 10,
                      right: 10,
                      child: Container(
                        width: 80,
                        height: 80,
                        color: Colors.blue,
                      ))
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildSwitch() => Switch(
      inactiveTrackColor: Colors.cyan,
      activeColor: Colors.red,
      value: _index == 0,
      onChanged: (v) => setState(() => _index = v ? 0 : 1));

// Widget _buildSwitch() => Switch(
//     value: _index == 0,
//     onChanged: (v) {
//       setState(() {
//         _index = v ? 0 : 1;
//       });
//     });
}
