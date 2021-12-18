import '../lib/file.dart';
import '../lib/utility.dart';

void main() async {
  List<String> lines = await readFile('./input.txt');
  List<int> inputs = lineToStrList(lines[0]);

  int least = double.maxFinite.round();

  int largestPoint =
      inputs.reduce((value, element) => element > value ? element : value);

  List.generate(largestPoint - 1, (i) => i).forEach((e) {
    int sum = sumFuel(inputs, e);
    if (sum < least) {
      least = sum;
    }
  });

  print(least);
}
