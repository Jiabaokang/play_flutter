import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'api.dart';

final Http http = Http();

class Http extends BaseHttp {
  @override
  void init() {
    options.baseUrl = 'https://www.wanandroid.com/';
    interceptors
      ..add(ApiInterceptor())
      // cookie持久化 异步
      ..add(CookieManager(PersistCookieJar()));
  }
}

/// 玩Android API
class ApiInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options,
      RequestInterceptorHandler handler) async{
    debugPrint('---api-request--->url--> ${options.baseUrl}${options.path}' +
        ' queryParameters: ${options.queryParameters}');
//    debugPrint('---api-request--->data--->${options.data}');
    handler.next(options);

  }

  @override
  onResponse(Response response,ResponseInterceptorHandler handler) {
//    debugPrint('---api-response--->resp----->${response.data}');
    ResponseData respData = ResponseData.fromJson(response.data);
    if (respData.success) {
      response.data = respData.data;
      handler.resolve(response);
    } else {
      if (respData.code == -1001) {
        // 如果cookie过期,需要清除本地存储的登录信息
        // StorageManager.localStorage.deleteItem(UserModel.keyUser);
        throw const UnAuthorizedException(); // 需要登录
      } else {
        throw NotSuccessException.fromRespData(respData);
      }
    }
  }
}

class ResponseData extends BaseResponseData {
  bool get success => 0 == code;

  ResponseData.fromJson(Map<String, dynamic> json) {
    code = json['errorCode'];
    message = json['errorMsg'];
    data = json['data'];
  }
}
