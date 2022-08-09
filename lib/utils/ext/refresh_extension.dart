import 'package:get/get_utils/get_utils.dart';
import 'package:play_flutter/res/strings.dart';
import 'package:play_flutter/utils/toast_util.dart';
import 'package:play_flutter/widget/pull_smart_refresher.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/8/9 11:23
/// desc   : 刷新异常的结果处理

class RefreshExtension{

  /// 刷新加载失败
  /// [controller] 刷新控制器
  /// [refresh] 加载类型 第一次、上拉、下拉
  static onError(RefreshController controller,Refresh refresh){
    if(refresh == Refresh.pull){
      controller.refreshFailed();
    }else if(refresh == Refresh.down){
      controller.loadFailed();
    }
  }


  /// 刷新数据成功
  /// [controller] 刷新控制器
  /// [refresh] 加载类型 第一次、上拉、下拉
  /// [isOver] 是否最后一次加载
  static onSuccess(RefreshController controller,Refresh refresh,bool isOver){
    ///加载成功，重置刷新状态
    if(refresh == Refresh.pull){
      controller.refreshCompleted();
    }else if(refresh == Refresh.down){
      controller.loadComplete();
    }

    ///最后一页的情况
    if(isOver){
      controller.loadNoData();
    }else{
      controller.loadComplete();
    }

    ///Toast提示
    if(refresh == Refresh.pull){
      ToastUtil.show(StringStyles.pointsNotifySuccess.tr);
    }
  }

}