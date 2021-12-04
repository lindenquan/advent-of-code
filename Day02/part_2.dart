import 'dart:io';
import 'dart:convert';

const path = 'input.txt';
var horizontal = 0;
var depth = 0;
var aim = 0;

enum Direction { forward, backward, up, down }

Direction toDirectionFromString(String value) =>
    Direction.values.firstWhere((e) => e.toString() == 'Direction.${value}');

class Command {
  Direction direction;
  int unit;

  Command(this.direction, this.unit);

  @override
  String toString() {
    return 'Direction: ${this.direction}, Unit: ${this.unit}';
  }
}

Command command(String line) {
  var commandList = line.split(RegExp(r'\s+'));
  return new Command(
      toDirectionFromString(commandList[0]), int.parse(commandList[1]));
}

void exeCommand(Command command) {
  switch (command.direction) {
    case Direction.forward:
      horizontal += command.unit;
      depth += aim * command.unit;
      break;
    case Direction.backward:
      horizontal -= command.unit;
      break;
    case Direction.up:
      aim -= command.unit;
      break;
    case Direction.down:
      aim += command.unit;
      break;
  }
}

void main() async {
  await new File(path)
      .openRead()
      .map(utf8.decode)
      .transform(new LineSplitter())
      .map(command)
      .forEach(exeCommand);

  print('horizontal:${horizontal}');
  print('depth: ${depth}');
  print(horizontal * depth);
}
