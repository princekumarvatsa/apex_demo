import 'package:apex_demo/constants/font_size.dart';
import 'package:apex_demo/provider/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LanguagePopup {
  static List<LocaleLanguage> languages = <LocaleLanguage>[LocaleLanguage("English", "en"), LocaleLanguage("Japanese", "ja")];
  static Widget show(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: Theme.of(context).primaryColor,
          ),
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 15.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  "Choose language",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: FontSize.large,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.h),
          child: Row(
            children: List.generate(
              languages.length,
              (index) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                    child: FittedBox(fit: BoxFit.scaleDown, child: Text(languages[index].languageName)),
                    onPressed: () {
                      context.read<LocaleProvider>().changeLocale(languages[index].languageCode);
                      Navigator.of(context).pop();
                    },
                    style: OutlinedButton.styleFrom(primary: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class LocaleLanguage {
  final String languageName;
  final String languageCode;
  LocaleLanguage(this.languageName, this.languageCode);
}
