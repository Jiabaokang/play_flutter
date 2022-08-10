import 'package:play_flutter/http/http_request.dart';
import 'package:play_flutter/http/request.dart';
import 'package:play_flutter/http/request_api.dart';
import 'package:play_flutter/model/home_model/banner_bean.dart';
import 'package:play_flutter/model/project_model/project_model.dart';
import 'package:play_flutter/model/structure_model/wechat_public_model.dart';

typedef SuccessOver<T> = Function(T data, bool over);

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/3/3 10:59
/// desc   : 数据请求仓库
class RequestRepository {
  ///登录接口
  login() {}

  ///注册接口
  register() {}

  ///首页Banner数据
  getBanner({Success<List<BannerBean>>? success, Fail? fail}) {
    Request.get<List<dynamic>>(RequestApi.apiBanner, {}, dialog: false,
        success: (data) {
      if (success != null) {
        var list = data.map((item) => BannerBean.fromJson(item)).toList();
        success(list);
      }
    }, fail: (code, msg) {
      if (fail != null) fail(code, msg);
    });
  }

  ///请求首页文章列表
  requestFirstPageArticle(
    int page, {
    SuccessOver<List<ProjectDetail>>? success,
    Fail? fail,
  }) {
    Request.get<dynamic>(
      //url
      RequestApi.apiHome.replaceFirst(RegExp("page"), "${page - 1}"),
      //json 参数
      {},
      //不显示dialog
      dialog: false,
      //成功回调
      success: (data) {
        var pageData = ProjectPage.fromJson(data);
        List<ProjectDetail> list = pageData.datas
            .map((value) => ProjectDetail.fromJson(value))
            .toList();
        if (success != null) {
          success(list, pageData.over);
        }
      },
      //失败回调
      fail: (code, msg) {
        if (fail != null) {
          fail(code, msg);
        }
      },
    );
  }


  ///获取微信公众号列表
  getWechatPublic({
    Success<List<WechatPublic>>? success,
    Fail? fail,
  }) {
    Request.get<List<dynamic>>(RequestApi.apiWechatPublic, {}, dialog: false,
        success: (data) {
          if (success != null) {
            var list = data.map((value) {
              return WechatPublic.fromJson(value);
            }).toList();
            success(list);
          }
        }, fail: (code, msg) {
          if (fail != null) {
            fail(code, msg);
          }
        });
  }
}
