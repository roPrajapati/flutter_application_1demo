import 'package:http/http.dart' as http;

enum APIType {
  GET,
  PUT,
  POST,
  PATCH,
  DELETE,
}

class RESTService {
  static Future<http.Response> performAPIRequest({
    required String httpUrl,
    required APIType apiType,
    bool isAuth = false,
    String contentType = 'application/json',
    String? body,
    Map<String, String>? header,
    Map<String, String> param = const {},
  }) async {
    if (param.isNotEmpty) {
      httpUrl += paramParser(param: param);
    }

    final request = http.Request(apiType.name, Uri.parse(httpUrl));
    final Map<String, String> headers = {
      'Content-Type': contentType,
    };

    if (isAuth) {
      headers['Authorization'] = 'Bearer ';

      if (header != null) {
        headers.addAll(header);
      }
    } 

    if (header != null) {
      headers.addAll(header);
    }
    if (body != null) {
      request.body = body;
    }
    request.followRedirects = false;
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final resultResponse = await http.Response.fromStream(response);

      return resultResponse;
    } else {
      final resultResponse = await http.Response.fromStream(response);
      throw resultResponse;
    }
  }

  static String paramParser({required Map<String, String> param}) {
    String parameter = '';
    for (String key in param.keys) {
      if (parameter.contains('?')) {
        parameter +=
            param[key] == null || param[key] == 'null' || param[key] == ''
                ? ''
                : '&$key=${param[key]}';
      } else {
        parameter +=
            param[key] == null || param[key] == 'null' || param[key] == ''
                ? ''
                : '?$key=${param[key]}';
      }
    }
    return parameter;
  }
}
