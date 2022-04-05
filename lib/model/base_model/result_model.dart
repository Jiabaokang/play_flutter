/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/4/5 23:24
/// desc   : 数据模型基类
class Result<T> {
  int errorCode;
  String errorMsg;
  T data;

  Result(this.errorCode, this.errorMsg, this.data);

  Result.fromJson(Map<String, dynamic> json)
      : errorCode = json['errorCode'],
        errorMsg = json['errorMsg'],
        data = json['data'];

  Map<String, dynamic> toJson() => {
        'errorCode': errorCode,
        'errorMsg': errorMsg,
        'data': data,
      };

  @override
  String toString() {
    return 'Result{errorCode: $errorCode, errorMsg: $errorMsg, data: $data}';
  }
}
