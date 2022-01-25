import 'package:apex_demo/constants/page_paths.dart';
import 'package:apex_demo/provider/authentication_provider.dart';
import 'package:apex_demo/provider/locale_provider.dart';
import 'package:apex_demo/provider/login_provider.dart';
import 'package:apex_demo/provider/tournaments_provider.dart';
import 'package:apex_demo/provider/user_provider.dart';
import 'package:apex_demo/routes/page_routes.dart';
import 'package:apex_demo/services/app_localization.dart';
import 'package:apex_demo/services/saved_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SavedPreferences.instance.initSharedPreferences();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => TournamentsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<LocaleProvider>(context).fetchSavedLocale();
    return ChangeNotifierProvider(
      create: (context) => LoginProvider(),
      child: Selector<LocaleProvider, Locale?>(
          selector: (context, localeProvider) => localeProvider.locale,
          builder: (context, locale, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Apex Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              locale: locale,
              localizationsDelegates: const [
                AppLocalizationDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale("en"),
                Locale("ja"),
              ],
              onGenerateRoute: PageRoutes.generateRoute,
              initialRoute: context.read<AuthenticationProvider>().isUserSignedIn ? PagePaths.homeScreen : PagePaths.loginScreen,
            );
          }),
    );
  }
}
