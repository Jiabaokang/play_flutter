class Article {
  final String? projectLink;
  final String? prefix;
  final bool? canEdit;
  final String? origin;
  final String? link;
  final String title;
  final num? type;
  final num? selfVisible;
  final String? apkLink;
  final String? envelopePic;
  final num? audit;
  final num? chapterId;
  final String? host;
  final num? realSuperChapterId;
  final num? id;
  final num? courseId;
  final String? superChapterName;
  final String? descMd;
  final String? niceShareDate;
  final num? visible;
  final String? niceDate;
  final String? author;
  final num? zan;
  final String? chapterName;
  final num? userId;
  final bool? adminAdd;
  final bool? isAdminAdd;
  final List<TagsItemEntity>? tags;
  final num? superChapterId;
  final bool? fresh;
  final bool? collect;
  final String? shareUser;
  final String? desc;

  Article({
    this.projectLink,
    this.prefix,
    this.canEdit,
    this.origin,
    this.link,
    this.title = '',
    this.type,
    this.selfVisible,
    this.apkLink,
    this.envelopePic,
    this.audit,
    this.chapterId,
    this.host,
    this.realSuperChapterId,
    this.id,
    this.courseId,
    this.superChapterName,
    this.descMd,
    this.niceShareDate,
    this.visible,
    this.niceDate,
    this.author,
    this.zan,
    this.chapterName,
    this.userId,
    this.adminAdd,
    this.isAdminAdd,
    this.tags,
    this.superChapterId,
    this.fresh,
    this.collect,
    this.shareUser,
    this.desc,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      projectLink: json['projectLink'],
      prefix: json['prefix'],
      canEdit: json['canEdit'],
      origin: json['origin'],
      link: json['link'],
      title: json['title'],
      type: json['type'],
      selfVisible: json['selfVisible'],
      apkLink: json['apkLink'],
      envelopePic: json['envelopePic'],
      audit: json['audit'],
      chapterId: json['chapterId'],
      host: json['host'],
      realSuperChapterId: json['realSuperChapterId'],
      id: json['id'],
      courseId: json['courseId'],
      superChapterName: json['superChapterName'],
      descMd: json['descMd'],
      niceShareDate: json['niceShareDate'],
      visible: json['visible'],
      niceDate: json['niceDate'],
      author: json['author'],
      zan: json['zan'],
      chapterName: json['chapterName'],
      userId: json['userId'],
      adminAdd: json['adminAdd'],
      isAdminAdd: json['isAdminAdd'],
      tags:
          json['tags'] == null ? null : List<TagsItemEntity>.from(json['tags'].map((x) => TagsItemEntity.fromJson(x))),
      superChapterId: json['superChapterId'],
      fresh: json['fresh'],
      collect: json['collect'],
      shareUser: json['shareUser'],
      desc: json['desc'],
    );
  }

  Map<String, dynamic> toJson() => {
        'projectLink': projectLink,
        'prefix': prefix,
        'canEdit': canEdit,
        'origin': origin,
        'link': link,
        'title': title,
        'type': type,
        'selfVisible': selfVisible,
        'apkLink': apkLink,
        'envelopePic': envelopePic,
        'audit': audit,
        'chapterId': chapterId,
        'host': host,
        'realSuperChapterId': realSuperChapterId,
        'id': id,
        'courseId': courseId,
        'superChapterName': superChapterName,
        'descMd': descMd,
        'niceShareDate': niceShareDate,
        'visible': visible,
        'niceDate': niceDate,
        'author': author,
        'zan': zan,
        'chapterName': chapterName,
        'userId': userId,
        'adminAdd': adminAdd,
        'isAdminAdd': isAdminAdd,
        'tags': tags?.map((e) => e.toJson()).toList(),
        'superChapterId': superChapterId,
        'fresh': fresh,
        'collect': collect,
        'shareUser': shareUser,
        'desc': desc,
      };
}

class TagsItemEntity {
  final String? name;
  final String? url;

  TagsItemEntity({
    this.name,
    this.url,
  });

  factory TagsItemEntity.fromJson(Map<String, dynamic> json) {
    return TagsItemEntity(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'url': url,
      };
}
