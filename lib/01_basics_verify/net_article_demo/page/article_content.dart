import 'dart:async';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:play_flutter/01_basics_verify/net_article_demo/api/article_api.dart';
import 'package:play_flutter/01_basics_verify/net_article_demo/models/article.dart';
import 'package:play_flutter/01_basics_verify/net_article_demo/page/article_detail_page.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ArticleContent extends StatefulWidget {
  const ArticleContent({super.key});

  @override
  State<ArticleContent> createState() => _ArticleContentState();
}

class _ArticleContentState extends State<ArticleContent> {
  ArticleApi articleApi = ArticleApi();

  bool _isLoading = false;

  List<Article> _articleList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    _isLoading = true;
    setState(() {});
    _articleList = await articleApi.loadArticleList(0);
    _isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _BodyContent();
  }

  Widget _BodyContent() {
    if (_isLoading) {
      return const Center(
        child: Wrap(
          spacing: 12,
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            CircularProgressIndicator(),
            Text("数据加载中，请稍等...", style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }
    return EasyRefresh(
      child: ListView.builder(
        itemExtent: 86, //列表项高度固定时，显式指定高度是一个好习惯(性能消耗小)
        itemCount: _articleList.length,
        itemBuilder: _buildItemByIndex,
      ),
      onRefresh: _onRefresh,
      onLoad: _onLoad,
    );
  }

  Widget? _buildItemByIndex(BuildContext context, int index) {
    return ArticleItem(articleItem: _articleList[index], onTap: _jumpToDetail);
  }

  void _jumpToDetail(Article article) {
    if (UniversalPlatform.isMacOS) {
      _launchUrl(article.link!);
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ArticleDetailPage(article: article),
        ),
      );
    }
  }

  void _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  void _onRefresh() async {
    _articleList = await articleApi.loadArticleList(0);
    setState(() {});
  }

  void _onLoad() async {
    int page = _articleList.length ~/ 20;
    print("_articleList.length:${_articleList.length},page:$page");
    var newList = await articleApi.loadArticleList(page);
    _articleList = _articleList + newList;
    setState(() {});
  }
}

class ArticleItem extends StatelessWidget {
  final Article articleItem;
  final ValueChanged<Article> onTap;

  const ArticleItem({Key? key, required this.articleItem, required this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onTap(articleItem);
        },
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        articleItem.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      articleItem.niceDate ?? '',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      articleItem.link ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
