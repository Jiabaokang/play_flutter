import 'package:dio/dio.dart';
import 'package:play_flutter/a_basics_verify/net_article_demo/models/article.dart';

class ArticleApi {
  static String baseUrl = "https://www.wanandroid.com/";

  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<List<Article>> loadArticleList(int page) async {
    String path = "article/list/$page/json";
    Response response = await _dio.get(path);
    if (response.statusCode == 200) {
      if (response.data != null) {
        print(response.data);
        var data = response.data['data']['datas'] as List;
        return data.map<Article>((item) => Article.fromJson(item)).toList();
      }
    }
    return [];
  }
}
