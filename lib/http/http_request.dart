import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:play_flutter/http/http_exception.dart';
import 'package:play_flutter/http/request_api.dart';
import 'package:play_flutter/model/user_model/user_bean.dart';
import 'package:play_flutter/utils/save/sp_util.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/3/16 16:48
/// desc   : 网络请求

/// 数据成功回调
typedef Success<T> = Function(T data);

/// 数据失败的回调
typedef Fail = Function(int code, String msg);

class HttpRequest {
  ///全局Dio对象
  static Dio? _dio;

  ///实例化Dio对象
  static Dio createInstance([bool isJson = false]) {
    if (_dio == null) {
      /// 配置Dio全局参数
      var option = BaseOptions()
        // 提交方式：1.表单提交 2.JSON方式提交
        // 请求的Content-Type，默认值是"application/json; charset=utf-8".
        // 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
        // 可以设置此选项为 `Headers.formUrlEncodedContentType`,  这样[Dio]就会自动编码请求体.
        ..contentType = isJson ? Headers.jsonContentType : Headers.formUrlEncodedContentType
        //验证状态
        ..validateStatus = ((status) {
          //不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
          return true;
        })
        //域名地址
        ..baseUrl = RequestApi.baseurl
        //发送超时
        ..sendTimeout = const Duration(milliseconds: 10000)
        //连接超时
        ..connectTimeout = const Duration(milliseconds: 10000)
        //接受超时
        ..receiveTimeout = const Duration(milliseconds: 10000);

      /// 实例化Dio对象
      _dio = Dio(option);
    }
    _dio?.options.contentType = isJson ? Headers.jsonContentType : Headers.formUrlEncodedContentType;

    return _dio!;
  }

  /// 执行网络请求，返回参数为 T
  /// [method]：请求方法，Method.POST等
  /// [path]：请求地址
  /// [params]：请求参数
  /// [success]：请求成功回调
  /// [error]：请求失败回调
  static Future request<T>(Method method, String path, dynamic params,
      {bool isJson = false, Success? success, required Fail fail}) async {
    try {
      ///请求之前检查网络连接
      var connectActivityResult = await Connectivity().checkConnectivity();

      ///网络连接异常
      if (connectActivityResult == ConnectivityResult.none) {
        _onError(HttpException.netError, '网络异常，请检查你的网络！', fail);
        return;
      }
      Dio _dio = createInstance(isJson);
      Response response = await _dio.request(path,
          data: params, options: Options(method: _MethodValue[method], headers: _headerToken()));

      ///设置成功的数据
      if (success != null) {
        success(response.data);
      }
    } on DioError catch (e) {
      NetError netError = HttpException.handleException(e);
      _onError(netError.code, netError.msg, fail);
      debugPrint("异常=====>$e");
    }
  }
}

///添加Cookie
Map<String, dynamic>? _headerToken() {
  /// 自定义Header,如需要添加token信息请调用此参数
  UserBean? userBean = SpUtil.getUserInfo();
  if (userBean != null) {
    Map<String, dynamic> httpHeaders = {
      'Cookie': 'loginUserName=${userBean.username};loginUserPassword=${userBean.password}',
    };
    return httpHeaders;
  }
  return null;
}

///网络请求失败的回调
/// [code] 错误代码
/// [msg] 错误信息
/// [fail] 错误回调
void _onError(int code, String msg, Fail? fail) {
  if (code == 0) {
    code = HttpException.unknownError;
    msg = '未知异常';
  }
  //fail!(code,msg);
  if (fail != null) {
    fail(code, msg);
  }
}

///解析Json数据
///[data] 返回的json数据
Map<String, dynamic> parseData(String data) {
  return json.decode(data) as Map<String, dynamic>;
}

///网络请求类型
enum Method { GET, POST, DELETE, PUT, PATCH, HEAD }

///网络请求类型的具体值
const _MethodValue = {
  Method.GET: "get",
  Method.POST: "post",
  Method.DELETE: "delete",
  Method.PUT: "put",
  Method.PATCH: "patch",
  Method.HEAD: "head"
};
