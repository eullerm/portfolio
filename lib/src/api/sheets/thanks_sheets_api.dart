import 'package:gsheets/gsheets.dart';
import 'package:portfolio/src/model/thanks.dart';

class ThanksSheetsApi {
  static Worksheet? _thanksSheet;

  static Future init({required Spreadsheet spreadsheet, required int page}) async {
    try {
      _thanksSheet = await _getWorkSheet(spreadsheet, page: page);
    } catch (e) {
      print('Project api error: $e');
    }
  }

  static Future<Worksheet?> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required int page,
  }) async {
    return await spreadsheet.worksheetById(page);
  }

  static Future<Thanks?> getByLanguage(String language) async {
    if (_thanksSheet == null) return null;

    final json = await _thanksSheet!.values.map.rowByKey(language, fromColumn: 1);
    return json == null ? null : Thanks.fromMap(json);
  }
}
