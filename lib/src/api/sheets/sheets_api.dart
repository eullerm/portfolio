import 'package:gsheets/gsheets.dart';
import 'package:portfolio/src/api/sheets/author_sheets_api.dart';
import 'package:portfolio/src/api/sheets/experience_sheets_api.dart';
import 'package:portfolio/src/model/author.dart';
import 'package:portfolio/src/model/experience.dart';

class SheetsApi {
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "portfolio-383423",
  "private_key_id": "5d9de2a582bfdcd70969e7eea8b7b22119c107b6",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEuwIBADANBgkqhkiG9w0BAQEFAASCBKUwggShAgEAAoIBAQDSOpqnlDSKuGBY\nEDBYq7elZLrG0kxITN8pb2xHuIh+8Cabk4MvRFKNx6POoA9UST4Fhe5WXlv2r5/q\nmlQ84FNQolS2rFQVWoGTwmH5OKMZA2TAMXOoo/ifevVRl3+CI+x2ol6hU/Gw6f7x\nsXuZnbUxV1Aqc+ZGDLZkOoQ8sh3h0AIT0ruRSwdVeVqC7dYaO7hYC+i1Dvyf56xh\ne6WoTOlKL6XaaOzRQh40XUTlWEV7F84JJfsPU5nucOS5eE192vWNWR7LgQosWSSh\nTmxLkgidjOy49PnuDsJ03ghohx8KUqHlp6g1vSEQ2neN9hjgcFdYBQ5Z2jexRojP\nHzX6DyPnAgMBAAECgf9A6K/mi4ysiMUu9k5LfVUUN0i2hIW2e3j2f6WXXo4hU559\nwrrybRHENFhA17ZaGPGLf4BkjcNtRd86nPAaYNgjGRNTUaxv8fS51DZuosGn9Cms\nFF2eRAcNueP/7vJmrSnGZ2Mj13YqTomAswyfWnuzCe9jjbBodo+cKXfseSyB8HCw\ndC8uh24c8xSVGE61X1Hr+5UgO08Z5UU9RWocD52ceNTxJ7Q79DXtpGU5OQSc7HQI\n+yBt7QmNXDQD+i6jc5zYH6kQhnAbaOFrwvebmtg56/xXlro7/7NuwsYZtqS2EmOj\n++GW+VjahfLqt6VocORkZtI/9Ntg7MDqpGkGGkkCgYEA9FHJTeyWs4ElhZwig9uV\n5/iBGaT5Rk9+jyuEmQJQtN5FDfMLcs5rCkwBzW8F6et4IBZRF5o1E0A3LT/ydvIH\nELdMdA2/pH7jW+75IvFyvk9zDKBGhFzC2pBEkQT533YoljxXZQC+Tw6UPxOXExTJ\ndv4iG7fGNOFiAxt03cQ2Yz8CgYEA3EeVz6egP2iV/ExUtY6t0Ayej0ake5KkKoGI\nQrq/tL0csDZNCPuT+kEWdRFUT1b2RvsozFvNyHbaBxvVE2NFf+EQiw+JJkVnt9pg\nFTUCtd5CbUwF/sSoKN9lh14hNgqJaZwidSVUaGAk9DTyRCFqt22MTdxIh5Whkxfx\nPTp3nVkCgYB28M4Aipo/HzNGHWHMMX2EJb2r312fdhnV10jBOJhTxRV3GghLxuPj\namdCPLdzTrf3XwXxaJhIG+4AsG34rBD2eVXV9c+DZGaJHgjZkxPaRFFtJyXNUF9o\nCe3nb7W5rQtLQGsHd9ouIJnZL09P8cG2lTfDqK7slYCipJ47TEdx/wKBgBSUj5ee\nFqe18sVmsEdiNDUK6MmEFRwCgFoETiHF5uFRBdwkxp+/OX0ZFasMWm8rNck97/rf\n3OMMz6P4Yrjz/mtLMMt9QRgVRfJ0caOplz48rMIfZzP9VaSz8n1qOvock+gNEV8W\nhMNXsDwssjHRWXIXxxMDMLeSME1Y4E4TJ1fJAoGBAKxav+k+m6Iwcz80nlvkwq4W\nXY5l8o0KaMLIx0xcWiipxdXdPSKEKAajwjNn8QNMaPZ+aQepExxN++ujSWgyut82\nCEwHe3eNOfAYsBq1lEXOcYs+82125U/+boA92bUj+p2ldnDGaNlbOnvzH+vfhAFx\n+GDO7fjMTIDLiPh5CEp1\n-----END PRIVATE KEY-----\n",
  "client_email": "portfolio@portfolio-383423.iam.gserviceaccount.com",
  "client_id": "102842154398686671576",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/portfolio%40portfolio-383423.iam.gserviceaccount.com"
}
''';
  static final _spreadsheetId = '1-0z7HvURYmWwSmCCY6FnM5P0wYniUooy3aSFM_TiCqg';
  static final _gsheets = GSheets(_credentials);
  static Map<String, int> worksheets = {
    'author': 815127933,
    'experiences': 1691098089,
  };

  static Future init() async {
    try {
      Spreadsheet spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      AuthorSheetsApi.init(spreadsheet: spreadsheet, page: worksheets['author']!);
      ExperienceSheetsApi.init(spreadsheet: spreadsheet, page: worksheets['experiences']!);
    } catch (e) {
      print('Init error: $e');
    }
  }

  static Future<Author?> getAuthor({required String language}) {
    return AuthorSheetsApi.getByLanguage(language);
  }

  static Future<Experiences?> getExperiences({required String language}) {
    return ExperienceSheetsApi.getByLanguage(language);
  }
}
