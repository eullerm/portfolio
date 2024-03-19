import 'package:gsheets/gsheets.dart';
import 'package:portfolio/src/model/projects.dart';

class ProjectsSheetsApi {
  static Worksheet? _projectSheet;

  static Future init({required Spreadsheet spreadsheet, required int page}) async {
    try {
      _projectSheet = await _getWorkSheet(spreadsheet, page: page);
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

  static Future<Projects?> get() async {
    if (_projectSheet == null) return null;

    final response = await _projectSheet!.values.map.allRows();
    print('response PROJECTS: ${response}');
    return response == null ? null : Projects.fromMap(response);
  }
}
