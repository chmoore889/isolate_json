## Introduction
This is a library for using a long-lived isolate to encode and decode JSONs.

## Usage

A simple usage example:

```dart
import 'package:isolate_json/isolate_json.dart';

Future<void> main() async {
  String json;
  final output1 = await JsonIsolate().decodeJson(json);

  final output2 = await JsonIsolate().encodeJson({
    'jsonData': true,
  });

  final output3 = await JsonIsolate().encodeJson([1, 2, 3]);

  print(output1);
  print(output2);
  print(output3);
}

```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/chmoore889/isolate_json/issues
