/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/8/9 10:44
/// desc   : Web实体类
///
class WebModel{

  /// 标题
  String title = '';
  /// 链接
  String link = '';
  /// ID
  int id = 0;
  /// 取消收藏专用此字段
  int originId = 0;
  /// 是否收藏
  bool isCollect = false;

  WebModel({this.title = '', this.link = '', this.id = 0, this.isCollect = false , this.originId = 0});

}