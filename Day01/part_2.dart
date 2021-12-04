import 'dart:io';
import 'dart:convert';

void main() async {
  var path = 'input_1_2.txt';
  var first = -1;
  var second = -1;
  var newList = await new File(path)
      .openRead()
      .map(utf8.decode)
      .transform(new LineSplitter())
      .map(int.parse)
      .map((element) {
    if (first == -1) {
      first = element;
      return -1;
    } else if (second == -1) {
      second = element;
      return -1;
    }

    var sum = first + second + element;
    first = second;
    second = element;
    return sum;
  }).toList();

  var count = 0;
  var previous = -1;
  newList.forEach((element) {
    if (previous != -1 && element > previous) {
      count++;
    }
    previous = element;
  });

  print(count);
}
