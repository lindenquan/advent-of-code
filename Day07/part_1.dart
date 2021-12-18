import '../lib/file.dart';
import '../lib/utility.dart';

void main() async {
  List<String> lines = await readFile('./input.txt');
  List<int> inputs = lineToStrList(lines[0]);
  int median = (inputs.length / 2).round();
  inputs.sort((a, b) => a - b);
  print(sumDistance(inputs, inputs[median - 1]));
}
