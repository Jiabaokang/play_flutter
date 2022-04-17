import 'package:play_flutter/http/http_request.dart';
import 'package:play_flutter/http/request.dart';
import 'package:play_flutter/http/request_api.dart';
import 'package:play_flutter/model/home_model/banner_bean.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/3/3 10:59
/// desc   : 数据请求仓库

class RequestRepository{

  ///登录接口
  login(){

  }

  ///注册接口
  register(){

  }

  ///首页Banner数据
  getBanner({Success<List<BannerBean>>? success,Fail? fail}){
    Request.get<List<dynamic>>(RequestApi.apiBanner, {},dialog: false,success: (data){
      if(success!= null){
        var list = data.map((item) => BannerBean.fromJson(item)).toList();
        success(list);
      }
    },fail: (code,msg){
      if(fail != null) fail(code,msg);
    });
  }



}