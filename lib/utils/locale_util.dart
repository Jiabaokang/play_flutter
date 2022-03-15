
import 'dart:ui';
import 'package:get/get.dart';
import 'package:play_flutter/config/lang/Language.dart';
import 'package:play_flutter/utils/save/sp_util.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/3/15 16:48
/// desc   : 本地国际化语言更新工具
///
class LocaleOptions{

  ///更新语言
  static updateLocale(Language language){
    Locale? locale;
    if(language.language == '' || language.country == ''){
      locale = Get.deviceLocale;
    }else{
      locale =  Locale(language.language , language.country);
    }
    if(locale != null){
      Get.updateLocale(locale);
    }
  }


  ///获取当前存储的默认语言
  static getDefault(){
    var language = SpUtil.getLanguage();
    if(language == null || language.language == '' || language.country == ''){
      return Get.deviceLocale;
    }else{
      return Locale(language.language , language.country);
    }
  }

}