import 'package:gsheets/gsheets.dart';
import 'package:portfolio/src/model/author.dart';

class AuthorSheetsApi {
  static Worksheet? _authorSheet;

  static Future init({required Spreadsheet spreadsheet, required int page}) async {
    try {
      _authorSheet = await _getWorkSheet(spreadsheet, page: page);
    } catch (e) {
      print('Author api error: $e');
    }
  }

  static Future<Worksheet?> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required int page,
  }) async {
    return await spreadsheet.worksheetById(page);
  }

  static Future<Author?> getByLanguage(String language) async {
    if (_authorSheet == null) return null;

    final json = await _authorSheet!.values.map.rowByKey(language, fromColumn: 1);

    return json == null ? null : Author.fromMap(json);
  }
}
