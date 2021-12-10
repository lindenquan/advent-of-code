import '../lib/file.dart';
import '../lib/vent.dart';

void main() async {
  List<String> lines = await readFile('./input.txt');
  List<Vent> vents = lines.map((e) => Vent(e)).toList();
  Board board = Board(vents);
  board.draw();

  print(board.count());
}
