// ignore_for_file: avoid_print

import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// Downloads a file from a [stream] into the destination [filename].
///
/// There are a few caveats about this function:
/// - On the web it caches the contents in a [Blob](https://developer.mozilla.org/en-US/docs/Web/API/Blob) and eventually saves the file in browser's default location.
/// - On desktop it saves the file in absolute or relative path.
/// - On mobile it saves the file in absolute or relative path, but we should ask/ensure if the app has the required permissions.
/// - On the web, not supported in IE or Edge (prior version 18), or in Safari (prior version 10.1).
Future<void> download(List<int> bytes, String filename) async {
  Directory? appDocDirectory = Platform.isAndroid
      ? Directory("/storage/emulated/0/Download/")
      : await getApplicationSupportDirectory();
  print(appDocDirectory.path + filename);
  final file = File(appDocDirectory.path + filename);
  file.writeAsBytes(bytes);
}
