import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:play_flutter/02_timer/app_config_bloc/app_config.dart';
import 'package:play_flutter/02_timer/app_config_bloc/app_config_bloc.dart';

void showLanguageSelectDialog(BuildContext context) {
  List<String> data = AppConfig.languagesSupports.keys.toList();
  showCupertinoModalPopup(
    context: context,
    builder: (context) => LanguageSelectDialog(data: data),
  );
}

class LanguageSelectDialog extends StatelessWidget {
  final List<String> data;

  const LanguageSelectDialog({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 350.0,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "选择语言",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: data.length,
                itemBuilder: _buildItem,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget? _buildItem(BuildContext context, int index) {
    Locale locale = AppConfig.languagesSupports.values.elementAt(index);
    Locale? currentLocale = BlocProvider.of<AppConfigBloc>(context).state.locale;
    bool checked = locale == currentLocale;
    Color color = Theme.of(context).primaryColor;
    return ListTile(
      title: Text(data[index]),
      trailing: checked ? Icon(Icons.check, color: color, size: 20) : null,
      onTap: () {
        _select(context, index);
      },
    );
  }

  void _select(BuildContext context, int index) {
    Locale locale = AppConfig.languagesSupports.values.elementAt(index);
    BlocProvider.of<AppConfigBloc>(context).switchLocal(locale);
    Navigator.of(context).pop();
  }
}
