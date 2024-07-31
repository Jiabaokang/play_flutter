import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_flutter/base/get/get_extension_method.dart';
import 'package:play_flutter/http/http_exception.dart';
import 'package:play_flutter/http/http_request.dart';
import 'package:play_flutter/http/request_api.dart';
import 'package:play_flutter/model/base_model/result_model.dart';
import 'package:play_flutter/utils/toast_util.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/3/17 00:55
/// desc   : 执行网络请求
class Request {
  /// 发起GET请求
  /// [url] 请求url
  /// [parameters] 请求参数
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  static void get<T>(
    String url,
    parameters, {
    bool isJson = false,
    bool dialog = true,
    Success<T>? success,
    Fail? fail,
  }) {
    _request(Method.GET, url, parameters, isJson: isJson, dialog: dialog, success: success, fail: fail);
  }

  /// 发起POST请求
  /// [url] 请求url
  /// [parameters] 请求参数
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  static void post<T>(
    String url,
    parameters, {
    bool isJson = false,
    bool dialog = true,
    Success<T>? success,
    Fail? fail,
  }) {
    _request(Method.POST, url, parameters, isJson: isJson, dialog: dialog, success: success, fail: fail);
  }

  /// 发起PUT请求
  /// [url] 请求url
  /// [parameters] 请求参数
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  static void put<T>(
    String url,
    parameters, {
    bool isJson = false,
    bool dialog = true,
    Success<T>? success,
    Fail? fail,
  }) {
    _request(Method.PUT, url, parameters, isJson: isJson, dialog: dialog, success: success, fail: fail);
  }

  /// 发起DELETE请求
  /// [url] 请求url
  /// [parameters] 请求参数
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  static void delete<T>(
    String url,
    parameters, {
    bool isJson = false,
    bool dialog = true,
    Success<T>? success,
    Fail? fail,
  }) {
    _request(Method.DELETE, url, parameters, isJson: isJson, dialog: dialog, success: success, fail: fail);
  }

  /// 发起网络请求
  /// [method]网络请求方式
  /// [url] 请求地址
  /// [parameters]请求参数
  /// [bool] 是否json类型
  /// [dialog]是否显示dialog
  /// [success]请求成功的回调
  /// [fail]请求失败的回调
  static void _request<T>(Method method, String url, parameters,
      {bool isJson = false, bool dialog = true, Success<T>? success, Fail? fail}) {
    if (dialog) {
      //get 扩展方法
      Get.showLoading();
    }
    debugPrint("request url==============> ${RequestApi.baseurl}$url");

    //Map<String, dynamic> _newParameters = parameters.map((key, value) => MapEntry(key.toString(), value));

    ///检验参数中是否携带URL
    parameters.forEach((key, value) {
      if (url.contains(key)) {
        url = url.replaceAll(":$key", value.toString());
      }
    });

    /// 开启网络请求
    HttpRequest.request(method, url, parameters, isJson: isJson,
        //成功
        success: (result) {
      if (dialog) Get.dismiss();
      if (success != null) {
        var resultModel = Result.fromJson(result);
        debugPrint("request success==============> $resultModel");

        //业务code
        if (resultModel.errorCode == HttpException.API_SUCCESS) {
          success(resultModel.data);
        } else {
          //其他的错误异常
          ToastUtil.show(resultModel.errorMsg);
        }
      }
    }, //失败
        fail: (code, msg) {
      debugPrint("request fail==============>code:$code, msg:$msg");
      if (dialog) Get.dismiss();
      ToastUtil.show(msg);
      if (fail != null) {
        fail(code, msg);
      }
    });
  }
}
