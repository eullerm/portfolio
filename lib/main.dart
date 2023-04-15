import 'package:flutter/material.dart';
import 'package:portfolio/src/api/sheets/author_sheets_api.dart';
import 'package:portfolio/src/model/author.dart';
import 'package:portfolio/src/storage/shared_preferences.dart';
import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:provider/provider.dart';

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());
  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await AuthorSheetsApi.init();
  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  final author = await getObjectFromPrefs('author');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Author.fromJson(author)),
      ],
      child: MyApp(settingsController: settingsController),
    ),
  );
}
