import 'dart:convert';
import 'dart:isolate';

class JsonIsolate {
  static final JsonIsolate _singleton = JsonIsolate._internal();

  SendPort? _sendPort;
  Isolate? _isolate;

  JsonIsolate._internal();

  /// Singleton for using JSONs in isolates.
  factory JsonIsolate() {
    return _singleton;
  }

  /// Decodes a JSON. Starts the isolate if it hasn't already been started.
  Future<dynamic> decodeJson(String json) async {
    if (_isolate == null || _sendPort == null) {
      await _makeIsolate();
    }

    return _sendReceive(_sendPort!, json, _JsonAction.decode);
  }

  /// Encodes a JSON. Starts the isolate if it hasn't already been started.
  Future<dynamic> encodeJson(dynamic toEncode) async {
    if (_isolate == null || _sendPort == null) {
      await _makeIsolate();
    }

    return _sendReceive(_sendPort!, toEncode, _JsonAction.encode);
  }

  /// Starts the isolate manually. It's not necessary to manually call this method as both the
  /// encoding and decoding functions will do it for you if it was not already done.
  Future<void> startIsolate() {
    return _makeIsolate();
  }

  /// Destroys the current isolate.
  void dispose() {
    _isolate?.kill();
    _isolate = null;
    _sendPort = null;
  }

  Future<void> _makeIsolate() async {
    final receivePort = ReceivePort();
    _isolate = await Isolate.spawn(
      _isolateDecode,
      receivePort.sendPort,
      debugName: 'json_isolate',
    );
    _sendPort = await receivePort.first;
    receivePort.close();
  }

  Future<dynamic> _sendReceive(
      SendPort port, dynamic json, _JsonAction action) async {
    final response = ReceivePort();
    port.send([json, action, response.sendPort]);
    dynamic decoded = await response.first;
    response.close();
    return decoded;
  }
}

void _isolateDecode(SendPort sendPort) async {
  final receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);

  await for (List msg in receivePort) {
    final message = msg[0];
    final _JsonAction action = msg[1];
    final SendPort replyTo = msg[2];

    dynamic data;
    if (action == _JsonAction.decode) {
      data = jsonDecode(message);
    } else if (action == _JsonAction.encode) {
      data = jsonEncode(message);
    } else {
      throw 'Invalid State';
    }

    replyTo.send(data);
  }
}

enum _JsonAction {
  encode,
  decode,
}
