import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'settings_controller.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    final SettingsController controller = context.read();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.setteings ?? "UNK"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        // Glue the SettingsController to the theme selection DropdownButton.
        //
        // When a user selects a theme from the dropdown list, the
        // SettingsController is updated, which rebuilds the MaterialApp.
        child: Column(
          children: [
            DropdownButton<String>(
              value: controller.locale,
              onChanged: (value) async {
                await controller.changeLocale(value!);
              },
              items: const [
                DropdownMenuItem(
                  value: "ar",
                  child: Text("Arabic"),
                ),
                DropdownMenuItem(
                  value: "en",
                  child: Text("English"),
                )
              ],
            ),
            DropdownButton<ThemeMode>(
              // Read the selected themeMode from the controller
              value: controller.themeMode,
              // Call the updateThemeMode method any time the user selects a theme.
              onChanged: controller.updateThemeMode,
              items: [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text(AppLocalizations.of(context)?.theme_sys ?? "UNK"),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child:
                      Text(AppLocalizations.of(context)?.theme_light ?? "UNK"),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child:
                      Text(AppLocalizations.of(context)?.theme_dark ?? "UNK"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
