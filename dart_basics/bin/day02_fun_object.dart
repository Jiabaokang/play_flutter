import 'dart:math';

///1、函数可以通过 typedef 定义类型，如下定义了一个 Operation 类型，表示一种入参是 double ，返回值是 double 的函数。
typedef Operation = double Function(double);

class Day02 {
  ///2、数的简单定义
  double square(double a) => a * a;
  double cube(double a) => a * a * a;

  ///函数类型方法入参
  double add(double a, double b, {Operation? op}) {
    if (op == null) return a + b;
    return op(a) + op(b);
  }

  void testFun() {
    ///3、可以声明一个 Operation 类型的 op 变量来指代 square 函数
    Operation op = square;
    Operation op2 = cube;
    print(op(3));
    print(op2(3));
    double result = add(3, 4, op: square);

    ///函数作为参数，一定要区分：func 和 func() 的区别，前者是作为参数，后者是返回值作为参数，而且后者会在传参的时候调用这个函数
    double result2 = add(3, 4, op: (double e) => e * e);
    print(result);
    print(result2);
  }

  void testNumType() {
    num a = 10;
    num b = 10.0;
    print("num a=10:${a.runtimeType}===num b=10.0:${b.runtimeType}");

    num pia = pi;
    print("pi绝对值:${pia.abs()}"); //绝对值
    print("pi向上取整:${pia.ceil()}"); //向上取整
    print("pi向下取整:${pia.floor()}"); //向下取整
    print("pi四舍五入取整:${pia.round()}"); //四舍五入取整
    print("pi去除小数部位取整:${pia.truncate()}"); //去除小数部位取整
    String v = pia.toStringAsFixed(2); //四舍五入，保留几位小数，返回字符串: 3.14
    print("pi四舍五入，保留几位小数，返回字符串:$v");

    int c = 10;
    print("数字10 转为2进制:${c.toRadixString(2)}");
    print("数字10 转为16进制:${c.toRadixString(16)}");
  }
}
