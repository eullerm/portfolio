import 'package:gsheets/gsheets.dart';
import 'package:portfolio/src/model/skills.dart';

class SkillsSheetsApi {
  static Worksheet? _skillsSheet;

  static Future init({required Spreadsheet spreadsheet, required int page}) async {
    try {
      _skillsSheet = await _getWorkSheet(spreadsheet, page: page);
    } catch (e) {
      print('Skills api error: $e');
    }
  }

  static Future<Worksheet?> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required int page,
  }) async {
    return await spreadsheet.worksheetById(page);
  }

  static Future<Skills?> get() async {
    if (_skillsSheet == null) return null;

    final json = await _skillsSheet!.values.map.allRows();
    print('JSON SKILLS: $json');
    return json == null ? null : Skills.fromMap(json);
  }
}
