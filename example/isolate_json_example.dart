import 'package:isolate_json/isolate_json.dart';

Future<void> main() async {
  final json = '{"name":"John", "age":30, "car":null}';
  final output1 = await JsonIsolate().decodeJson(json);

  final output2 = await JsonIsolate().encodeJson({
    'jsonData': true,
  });

  final output3 = await JsonIsolate().encodeJson([1, 2, 3]);

  print(output1);
  print(output2);
  print(output3);
}
