List<int> lineToStrList(String line) {
  return line.split(',').map((e) => int.parse(e)).toList();
}

int sumDistance(List<int> input, int point) {
  int sum = 0;
  input.forEach((e) => sum += (e - point).abs());
  return sum;
}

int sumFuel(List<int> input, int point) {
  int sum = 0;
  input.forEach((e) => sum += sumTo((e - point).abs()));
  return sum;
}

int sumTo(int v) {
  return ((1 + v) * v / 2).round();
}
