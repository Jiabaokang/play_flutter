import 'package:dio/dio.dart';
import 'package:play_flutter/config/net/api.dart';
import 'package:play_flutter/utils/platform_utils.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/3/16 16:08
/// desc   : 数据请求错误信息处理
class HttpException {
  static const int success = 200;
  static const int API_SUCCESS = 0;

  static const int successNotContent = 204;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;

  static const netError = 1000;
  static const int parseError = 1001;
  static const int socketError = 1002;
  static const int httpError = 1003;
  static const int timeoutError = 1004;
  static const int cancelError = 1005;
  static const int unknownError = 9999;

  static NetError handleException(DioError? dioError) {
    if (dioError != null) {
      ///DioError返回的错误类型
      switch (dioError.type) {
        ///请求响应错误处理
        case DioExceptionType.badResponse:
          {
            dynamic error = dioError.message;
            if (error is SocketException) {
              return NetError(socketError, "网络异常，请检查你的网络！");
            } else if (error is HttpException) {
              return NetError(httpError, "服务器异常");
            } else if (error is FormatException) {
              return NetError(parseError, '数据解析异常');
            } else {
              return NetError(netError, '网络异常，请检查你的网络！');
            }
          }

        ///连接超时 || 请求超时 || 响应超时
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.connectionTimeout:
          {
            return NetError(timeoutError, '连接超时！');
          }
        case DioExceptionType.cancel:
          {
            return NetError(cancelError, '取消请求');
          }
        default:
          {
            return NetError(unknownError, "位置异常");
          }
      }
    } else {
      return NetError(unknownError, "未知异常");
    }
  }
}

class NetError {
  int code;
  String msg;

  NetError(this.code, this.msg);
}
