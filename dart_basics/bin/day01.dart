import 'dart:io';

class Day01 {
  ///算数运算
  void countOperation() {
    print("算数运算");
    print("加: 1 + 2 = ${1 + 2}");
    print("减: 1 - 2 = ${1 - 2}");
    print("乘: 1 * 2 = ${1 * 2}");
    print("除: 1 / 2 = ${1 / 2}");
    print("余: 10 % 3 = ${10 % 3}");
    print("商: 10 ～/ 3 = ${10 ~/ 3}");
  }

  ///比较运算
  void compareOperation() {
    print("\n 比较运算");
    print("1 > 2 = ${1 > 2}"); //false   大于
    print("1 < 2 = ${1 < 2}"); //false   大于
    print("1 == 2 = ${1 == 2}"); //false  等于
    print("1 != 2 = ${1 != 2}"); //true   不等
    print("10 >= 3 = ${10 >= 3}"); //true  大于等于
    print("10 <= 3 = ${10 <= 3}"); //false 小于等于
  }

  void forLoop() {
    print("\n -----------for循环开始------------");
    int sum = 0;
    for (int i = 0; i < 10; i++) {
      sum = sum + i;
      print("第$i 次执行,sum = $sum");
    }
    print("------------for循环结束-------------");
  }

  void whileLoop() {
    print("\n -----------do while循环开始------------");
    int sum = 0;
    int i = 0;
    do {
      sum = sum + i;
      print("do while 第$i 次执行,sum = $sum");
      i++;
    } while (i < 10);
    print("------------ do while循环结束-------------");
  }

  ///集合中的数据不允许重复
  void testSet() {
    Set<int> numSet = {1, 3, 4, 5, 5, 6, 7, 8, 8, 9, 9, 10};
    print("\n ------------验证Set集合---------------");
    print("集合中的数据不允许重复");
    print("集合中的数据:$numSet");
    print("集合的长度:${numSet.length}");
    print("集合是否包含3:${numSet.contains(3)}");
    print("集合是否包含100:${numSet.contains(100)}");
    print("集合是否为空:${numSet.isEmpty}");
    print("集合是否不为空:${numSet.isNotEmpty}");
    print("集合通过for-in遍历元素的值");
    for (var item in numSet) {
      print("集合中的元素:$item");
    }
  }

  ///验证map
  void testMap() {
    print("\n ------------验证Map集合---------------");
    Map<int, String> map = {0: "Zero", 1: "One", 2: "Two", 3: "Three"};
    print("Map集合中的数据:$map");
    print("Map集合的长度:${map.length}");
    print("Map集合是否包含Zero:${map.containsKey(0)}");
    print("Map集合是否包含One:${map.containsValue("One")}");
    print("Map集合是否包含Ten:${map.containsKey(4)}");
  }

  ///
  /// 函数的简单定义
  /// 计算BMI
  /// @param weight 体重
  /// @param height 身高
  double bmi(double weight, double height) {
    return weight / (height * height);
  }

  ///命名参数
  double bmi2({required double weight, required double height}) {
    return weight / (height * height);
  }

  ///位置参数
  double bmi3([double weight = 0, double height = 0]) {
    return weight / (height * height);
  }

  void testClass() {
    print("\n ------------验证类的属性和方法---------------");
    Human human = Human("张三", 20);
    human.say();

    Human student = Student("李四", 20, school: "清华大学");
    student.say();
  }

  Future<void> readFile() async {
    // 文件路径
    final filePath = '/Users/jiabaokang/AndroidDeveloper/FlutterProject/play_flutter/pubspec.yaml';
    // 读取文件
    final file = File(filePath);
    final fileContent = await file.readAsString();
    // 获取文件大小
    final fileSizeInBytes = file.lengthSync();
    // 打印文件内容
    print('文件内容: $fileContent');
    // 打印文件大小
    print('文件大小: $fileSizeInBytes 字节');
  }
}

/// 类的定义
class Human {
  String name;
  int age;

  Human(this.name, this.age);

  void say() {
    print("我的名字是:$name,我的年龄是:$age");
  }
}

///类的继承
class Student extends Human {
  final String school;
  Student(super.name, super.age, {required this.school});

  @override
  void say() {
    print("我的名字是:$name,我的年龄是:$age,我的学校是:$school");
  }
}
