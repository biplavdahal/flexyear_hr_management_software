import 'dart:convert';
import 'dart:io';

class FileHelper {
  static String getBase64(File file) {
    final bytes = file.readAsBytesSync();

    return "data:image/png;base64," + base64Encode(bytes);
  }
}
