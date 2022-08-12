import 'package:play_flutter/base/get/controller/base_page_controller.dart';
import 'package:play_flutter/model/project_model/project_model.dart';
import 'package:play_flutter/utils/ext/refresh_extension.dart';
import 'package:play_flutter/widget/pull_smart_refresher.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class AskLogic extends BaseGetPageController {

  List<ProjectDetail> projectList = [];

  @override
  void requestData(RefreshController controller,
      {Refresh refresh = Refresh.first}) {
    request.getAskList(
      page,
      callSuccess: (data, isOver) {
        RefreshExtension.onSuccess(controller, refresh, isOver);

        if(refresh == Refresh.down){
          projectList.clear();
        }
        projectList.addAll(data);
        showSuccess(projectList);
        update();
      },
      callFail: (code, msg) {
        RefreshExtension.onError(controller, refresh);
      },
    );
  }
}
