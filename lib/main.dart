import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:portfolio/src/api/sheets/sheets_api.dart';
import 'package:portfolio/src/model/author.dart';
import 'package:portfolio/src/model/experience.dart';
import 'package:portfolio/src/model/skills.dart';
import 'package:portfolio/src/storage/local_storage.dart';
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
  await SheetsApi.init();
  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  String authorJson = await getObject('author');
  String experiencesJson = await getObject('experiences');
  String languageJson = await getObject('language');
  String lastFetchJson = await getObject('lastFetch');
  String skillsJson = await getObject('skills');

  if (lastFetchJson.isEmpty || DateTime.now().difference(DateTime.parse(lastFetchJson)).inDays > 7) {
    saveObject('lastFetch', DateTime.now().toString());
  }

  if (languageJson.isEmpty || lastFetchJson.isEmpty || DateTime.now().difference(DateTime.parse(lastFetchJson)).inDays > 7) {
    saveObject('language', jsonEncode({'portuguese': 'Português'}));
  }
  if (authorJson.isEmpty || lastFetchJson.isEmpty || DateTime.now().difference(DateTime.parse(lastFetchJson)).inDays > 7) {
    authorJson = (await SheetsApi.getAuthor(language: 'portuguese'))?.toJson() ?? '';
    saveObject('author', authorJson);
  }
  if (experiencesJson.isEmpty || lastFetchJson.isEmpty || DateTime.now().difference(DateTime.parse(lastFetchJson)).inDays > 7) {
    experiencesJson = (await SheetsApi.getExperiences(language: 'portuguese'))?.toJson() ?? '';
    saveObject('experiences', experiencesJson);
  }
  if (skillsJson.isEmpty || lastFetchJson.isEmpty || DateTime.now().difference(DateTime.parse(lastFetchJson)).inDays > 7) {
    skillsJson = (await SheetsApi.getSkills())?.toJson() ?? '';
    saveObject('skills', skillsJson);
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Author.fromJson(authorJson)),
        ChangeNotifierProvider(create: (_) => Experiences.fromJson(experiencesJson)),
      ],
      child: MyApp(settingsController: settingsController),
    ),
  );
}
