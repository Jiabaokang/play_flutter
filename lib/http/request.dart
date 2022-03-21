
import 'package:get/get.dart';
import 'package:play_flutter/http/http_request.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/3/17 00:55
/// desc   : 执行网络请求
class Request {
  ///
  ///
  static void get<T>() {}

  static void post<T>() {}

  static void put<T>() {}

  static void delete<T>() {}

  static void _request<T>(Method method, String url, parameters,
      {bool isJson = false,
      bool dialog = true,
      Success<T>? success,
      Fail? fail}) {
    if(dialog){
      ///TODO Get
    }
  }
}
