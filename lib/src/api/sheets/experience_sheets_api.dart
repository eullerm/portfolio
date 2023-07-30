import 'package:gsheets/gsheets.dart';
import 'package:portfolio/src/model/experience.dart';

class ExperienceSheetsApi {
  static Worksheet? _experienceSheet;

  static Future init({required Spreadsheet spreadsheet, required int page}) async {
    try {
      _experienceSheet = await _getWorkSheet(spreadsheet, page: page);
    } catch (e) {
      print('Experience api error: $e');
    }
  }

  static Future<Worksheet?> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required int page,
  }) async {
    return await spreadsheet.worksheetById(page);
  }

  static Future<Experiences?> getByLanguage(String language) async {
    if (_experienceSheet == null) return null;

    final response = await _experienceSheet!.values.map.allRows();
    final filteredResponse = response != null ? response.where((row) => row['language'] == language).map((row) => row).toList() : [];
    print(filteredResponse);
    return response == null ? null : Experiences.fromMap(filteredResponse);
  }
}
