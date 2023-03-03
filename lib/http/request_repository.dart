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

  /// 请求广场列表接口
  /// [page] 当前第几页
  /// [callSuccess] 成功回调
  /// [callFail] 失败回调
  getSquareModule(
    int page, {
    required SuccessOver<List<ProjectDetail>> callSuccess,
    required Fail callFail,
  }) {
    Request.get<dynamic>(
      RequestApi.apiSquare.replaceFirst(RegExp("page"), "${page - 1}"),
      {},
      dialog: false,
      success: (data) {
        var projectPage = ProjectPage.fromJson(data);
        List<ProjectDetail> projectList = projectPage.datas
            .map((json) => ProjectDetail.fromJson(json))
            .toList();

        callSuccess(projectList, projectPage.over);
      },
      fail: (code, msg) {
        callFail(code, msg);
      },
    );
  }

  ///获取问答列表数据
  /// [page] 当前第几页
  /// [callSuccess] 成功回调
  /// [callFail] 失败回调
  getAskList(
    int page, {
    required SuccessOver<List<ProjectDetail>> callSuccess,
    required Fail callFail,
  }) {
    //请求地址
    var url = RequestApi.apiAsk.replaceFirst(RegExp("page"), "${page - 1}");

    ///执行具体的网络请求，将结果对调给调用方
    Request.get<dynamic>(
      url,
      {},
      dialog: false,
      success: (data) {
        //分页数据
        ProjectPage projectData = ProjectPage.fromJson(data);
        //列表数据
        List<ProjectDetail> projectList = projectData.datas
            .map((json) => ProjectDetail.fromJson(json))
            .toList();

        ///将请求成成并解析后的数据回调出去
        callSuccess(projectList, projectData.over);
      },

      ///将请求失败的结果回调出去
      fail: (code, msg) {
        callFail(code, msg);
      },
    );
  }


}
