import 'package:play_flutter/base/get/controller/base_page_controller.dart';
import 'package:play_flutter/model/project_model/project_model.dart';
import 'package:play_flutter/utils/ext/refresh_extension.dart';
import 'package:play_flutter/widget/pull_smart_refresher.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/8/11 17:38
/// desc   : 请求广场的文章列表

class SquareLogic extends BaseGetPageController {
  List<ProjectDetail> projectList = [];

  @override
  void requestData(RefreshController controller,
      {Refresh refresh = Refresh.first}) {
    request.getSquareModule(
      page,

      ///成功的结果处理
      callSuccess: (data, isOver) {
        RefreshExtension.onSuccess(controller, refresh, isOver);
        //下拉刷新，清楚列表数据
        if (refresh == Refresh.down) {
          projectList.clear();
        }
        projectList.addAll(data);
        showSuccess(projectList);
        update();
      },

      ///失败的结果处理
      callFail: (code, msg) {
        showFailed();
        RefreshExtension.onError(controller, refresh);
      },
    );
  }
}
