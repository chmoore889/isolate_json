## Introduction
This is a library for using a long-lived isolate to encode and decode JSONs.

When in a VM it uses isolates. This package is able to support web by falling back to encoding/decoding without isolates on web. This is so that an application using this package does not have to do that check itself.

## Usage

A simple usage example:

```dart
import 'package:isolate_json/isolate_json.dart';

Future<void> main() async {
  await JsonIsolate().startIsolate();

  final json = '{"name":"John", "age":30, "car":null}';
  final output1 = await JsonIsolate().decodeJson(json);

  final output2 = await JsonIsolate().encodeJson({
    'jsonData': true,
  });

  final output3 = await JsonIsolate().encodeJson([1, 2, 3]);

  print(output1);
  print(output2);
  print(output3);

  JsonIsolate().dispose();
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/chmoore889/isolate_json/issues
