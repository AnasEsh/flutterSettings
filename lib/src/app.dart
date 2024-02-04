import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:restore_config/src/router.dart';
import 'package:restore_config/src/services/userService.dart';
import 'package:restore_config/src/utils/di.dart';
import 'package:restore_config/src/viewModels/userVm.dart';
import 'package:restore_config/src/views/auth/Login.dart';

import 'settings/settings_controller.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The ListenableBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return
    
     MultiProvider(providers: [
      ChangeNotifierProvider<UserViewModel>(create: (context) => UserViewModel(),)
     ],builder: (context, _) {
       return ListenableBuilder(
        listenable: settingsController,
        builder: (BuildContext context, Widget? child) {
          // dependincies.registerSingleton(AppLocalizations.of(context)!);
          return MaterialApp(
              locale: Locale(settingsController.locale),
              // Providing a restorationScopeId allows the Navigator built by the
              // MaterialApp to restore the navigation stack when a user leaves and
              // returns to the app after it has been killed while running in the
              // background.
              restorationScopeId: 'app_26926',
       
              // Provide the generated AppLocalizations to the MaterialApp. This
              // allows descendant Widgets to display the correct translations
              // depending on the user's locale.
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en', ''),
                Locale('ar', ''),
              ],
       
              // Use AppLocalizations to configure the correct application title
              // depending on the user's locale.
              //
              // The appTitle is defined in .arb files found in the localization
              // directory.
              // onGenerateTitle: (BuildContext context) =>
              //     AppLocalizations.of(context)!.appTitle,
              title: dependincies.get<AppLocalizations>().appTitle ?? "Unk",
              // Define a light and dark color theme. Then, read the user's
              // preferred ThemeMode (light, dark, or system default) from the
              // SettingsController to display the correct theme.
              theme: ThemeData().copyWith(
                  inputDecorationTheme: InputDecorationTheme(
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(const Radius.circular(20)),
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary)))),
              darkTheme: ThemeData.dark(),
              themeMode: settingsController.themeMode,
       
              // Define a function to handle named routes in order to support
              // Flutter web url navigation and deep linking.
              onGenerateRoute: AppRouter.onGenerate
              // (RouteSettings routeSettings) {
              //   return MaterialPageRoute<void>(
              //     settings: routeSettings,
              //     builder: (BuildContext context) {
              //       switch (routeSettings.name) {
              //         case SettingsView.routeName:
              //           return SettingsView(controller: settingsController);
              //         case SampleItemDetailsView.routeName:
              //           return const SampleItemDetailsView();
              //         case SampleItemListView.routeName:
              //         default:
              //           return const SampleItemListView();
              //       }
              //     },
              //   );
              // },
              );
        },
           );
     },
     );
  }
}
