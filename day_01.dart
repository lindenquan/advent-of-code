#!/usr/bin/env dart

import 'dart:io';
import 'dart:convert';

void main() async {
  var path = 'day_01.input';
  var count = 0;
  await new File(path)
      .openRead()
      .map(utf8.decode)
      .transform(new LineSplitter())
      .map(int.parse)
      .reduce((previous, element) {
    if (element > previous) {
      count++;
    }
    return element;
  });

  print(count);
}
