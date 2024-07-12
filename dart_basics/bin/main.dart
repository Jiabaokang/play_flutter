import 'day01.dart';

void main(List<String> arguments) {
  var day01 = Day01();
  day01.countOperation();
  day01.compareOperation();
  day01.forLoop();
  day01.whileLoop();
  day01.testSet();
  day01.testMap();
  day01.readFile();

  print("\n----------------方法的定义-------------");
  print("函数的简单定义:${day01.bmi(80, 1.8)}");
  print("命名参数:${day01.bmi2(weight: 80, height: 1.8)}");
  print("位置参数:${day01.bmi3(80, 1.8)}");

  day01.testClass();
}
