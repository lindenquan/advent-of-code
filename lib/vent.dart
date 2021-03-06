class Coordinate {
  int x;
  int y;

  Coordinate(this.x, this.y);

  @override
  String toString() {
    return '${x}, ${y}';
  }
}

class Vent {
  Coordinate start = Coordinate(0, 0);
  Coordinate end = Coordinate(0, 0);

  Vent(String value) {
    var xy = value.split('->');
    var x1y1 = xy[0].split(',');
    var x2y2 = xy[1].split(',');
    this.start = Coordinate(int.parse(x1y1[0]), int.parse(x1y1[1]));
    this.end = Coordinate(int.parse(x2y2[0]), int.parse(x2y2[1]));
  }

  @override
  String toString() {
    return '{${this.start} -> ${this.end}}';
  }
}

class Board {
  List<List<int>> board = [];
  List<Vent> vents = [];

  Board(List<Vent> vents) {
    this.vents = vents;
    int maxX = 0;
    int maxY = 0;

    vents.forEach((vent) {
      if (vent.start.x > maxX) {
        maxX = vent.start.x;
      }
      if (vent.end.x > maxX) {
        maxX = vent.end.x;
      }
      if (vent.start.y > maxY) {
        maxY = vent.start.y;
      }
      if (vent.end.y > maxY) {
        maxY = vent.end.y;
      }
    });

    this.board = List.generate(maxY + 1, (index) => List.filled(maxX + 1, 0));
  }

  int count() {
    var count = 0;
    this.board.forEach((row) {
      row.forEach((element) {
        if (element > 1) {
          count++;
        }
      });
    });
    return count;
  }

  void draw([bool diagnal = false]) {
    this.vents.forEach((vent) {
      if (vent.start.y == vent.end.y && vent.start.x == vent.end.x) {
        this.board[vent.start.y][vent.start.x] += 1;
      } else if (vent.start.y == vent.end.y) {
        var smallIndex = vent.start.x < vent.end.x ? vent.start.x : vent.end.x;
        var bigIndex = smallIndex == vent.start.x ? vent.end.x : vent.start.x;
        for (int i = smallIndex; i <= bigIndex; i++) {
          this.board[vent.start.y][i] += 1;
        }
      } else if (vent.start.x == vent.end.x) {
        var smallIndex = vent.start.y < vent.end.y ? vent.start.y : vent.end.y;
        var bigIndex = smallIndex == vent.start.y ? vent.end.y : vent.start.y;
        for (int i = smallIndex; i <= bigIndex; i++) {
          this.board[i][vent.start.x] += 1;
        }
      } else if (diagnal) {
        Coordinate start = vent.start.y < vent.end.y ? vent.start : vent.end;
        Coordinate end = start.y == vent.start.y ? vent.end : vent.start;

        bool isForward = end.x > start.x;
        if (end.y - start.y == (end.x - start.x).abs())
          for (int i = start.y; i <= end.y; i++) {
            var offset = isForward ? i - start.y : start.y - i;
            this.board[i][start.x + offset] += 1;
          }
      }
    });
  }
}
