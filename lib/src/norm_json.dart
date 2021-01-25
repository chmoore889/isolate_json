import 'dart:convert';

class JsonIsolate {
  static final JsonIsolate _singleton = JsonIsolate._internal();

  JsonIsolate._internal();

  /// Singleton for using JSONs in isolates.
  factory JsonIsolate() {
    return _singleton;
  }

  /// Decodes a JSON without an isolate.
  ///
  /// Intended only when using the package on web.
  Future<dynamic> decodeJson(String json) async {
    return jsonDecode(json);
  }

  /// Decodes a JSON without an isolate.
  ///
  /// Intended only when using the package on web.
  Future<dynamic> encodeJson(dynamic toEncode) async {
    return jsonEncode(toEncode);
  }
}
