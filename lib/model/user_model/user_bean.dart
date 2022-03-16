/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/3/16 22:37
/// desc   : 用户实体类
class UserBean {
  bool admin = false;
  List<dynamic> chapterTops = [];
  int coinCount = 0;
  List<dynamic> collectIds = [];
  String email = '';
  String icon = '';
  int id = 0;
  String nickname = '';
  String password = '';
  String publicName = '';
  String token = '';
  int type = 0;
  String username = '';

  UserBean({
    required this.admin,
    required this.chapterTops,
    required this.coinCount,
    required this.collectIds,
    required this.email,
    required this.icon,
    required this.id,
    required this.nickname,
    required this.password,
    required this.publicName,
    required this.token,
    required this.type,
    required this.username,
  });

  factory UserBean.fromJson(Map<String, dynamic> json) {
    return UserBean(
      admin: json['admin'],
      chapterTops: json['chapterTops'],
      coinCount: json['coinCount'],
      collectIds: json['collectIds'],
      email: json['email'],
      icon: json['icon'],
      id: json['id'],
      nickname: json['nickname'],
      password: json['password'],
      publicName: json['publicName'],
      token: json['token'],
      type: json['type'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() => {
        'admin': admin,
        'chapterTops': chapterTops,
        'coinCount': coinCount,
        'collectIds': collectIds,
        'email': email,
        'icon': icon,
        'id': id,
        'nickname': nickname,
        'password': password,
        'publicName': publicName,
        'token': token,
        'type': type,
        'username': username,
      };
}
