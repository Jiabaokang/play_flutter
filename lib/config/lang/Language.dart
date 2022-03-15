import 'package:play_flutter/res/strings.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/3/15 17:00
/// desc   : 国际化语言配置实体类
class Language {
  String name = '';
  String language = '';
  String country = '';
  bool isSelect = false;

  Language(this.name, this.language, this.country, {this.isSelect = false});

  Language.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        language = json['language'],
        country = json['country'],
        isSelect = json['isSelect'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'language': language,
        'country': country,
        'isSelect': isSelect,
      };

  @override
  String toString() {
    return 'Language{name: $name, language: $language, country: $country, isSelect: $isSelect}';
  }
}

///新增语言要在此处手动增加
final languageList = [
  //默认配置
  Language(StringStyles.settingLanguageDefault, "", ""),
  Language('简体中文', 'zh', 'CN'),
  Language('繁體中文(香港)', 'zh', 'HK'),
  Language('繁體中文(台灣)', 'zh', 'TW'),
  Language('English', 'zh', 'US'),

];
