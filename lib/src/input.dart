import 'dart:io';
import 'dart:convert';

Future<List<String>> readFile(String filePath) {
  return File(filePath)
      .openRead()
      .map(utf8.decode)
      .transform(new LineSplitter())
      .toList();
}
