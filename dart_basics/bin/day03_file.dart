import 'dart:io';
import 'package:path/path.dart' as path;

class Day03File {
  int fileLength = 0;
  int counter = 0;

  ///1、文件读取
  void readFile() async {
    String filePath = path.join(Directory.current.parent.path, "pubspec.lock");
    File file = File(filePath);
    fileLength = await file.length();
    print('开始读取文件：$filePath');
    Stream<List<int>> stream = file.openRead();
    stream.listen(_onDate, onDone: _onDone);
  }

  ///2、文件读取回调
  void _onDate(List<int> bytes) {
    counter += bytes.length;
    double progress = counter * 100 / fileLength;
    DateTime time = DateTime.now();
    String timeStr = "[${time.hour}:${time.minute}:${time.second}:${time.millisecond}]";
    print('$timeStr${"=" * (progress ~/ 2)}[${progress.toStringAsFixed(2)}%]');
  }

  ///3、文件读取完成
  void _onDone() {
    print('文件读取完成');
  }
}

class A {
  final String name;
  A(this.name);
  void run() {
    print("run in a");
  }
}

class B {
  final String name;
  B(this.name);
  void log() {
    print("run in b");
  }
}

class C implements A, B {
  @override
  void run() {}

  @override
  String get name => "C";

  @override
  void log() {}
}

// class FishMan{
//   final OnBiteCallBack hook;
//   FishMan(this.hook);
// }
