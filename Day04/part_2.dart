import 'dart:io';
import 'dart:convert';
import 'dart:async';

class Board {
  static int found = -1;
  List<List<int>> board = [];
  final int size;

  Board([this.size = 5]);

  void addRow(String row) {
    board.add(row
        .split(RegExp(r'\s+'))
        .skipWhile((value) => value == '')
        .map<int>(int.parse)
        .toList());
  }

  bool isBingo(List<int> rowCol) {
    bool rowBingo = this
            .board[rowCol[0]]
            .takeWhile((value) => value == Board.found)
            .length ==
        this.size;
    if (rowBingo) {
      return true;
    }

    for (var rowIndex = 0; rowIndex < this.size; rowIndex++) {
      if (this.board[rowIndex][rowCol[1]] != Board.found) {
        return false;
      }
    }
    return true;
  }

  List<int> called(int num) {
    for (var rowIndex = 0; rowIndex < this.size; rowIndex++) {
      for (var colIndex = 0; colIndex < this.size; colIndex++) {
        if (this.board[rowIndex][colIndex] == num) {
          this.board[rowIndex][colIndex] = Board.found;
          return [rowIndex, colIndex];
        }
      }
    }

    return [];
  }

  int sumOfUnmarked() {
    int sum = 0;
    this.board.forEach((row) {
      row.forEach((element) {
        if (element != Board.found) {
          sum += element;
        }
      });
    });
    return sum;
  }

  void printBoard() {
    this.board.forEach((row) {
      row.forEach((element) {
        stdout.write(element);
        stdout.write(',');
      });
      print('');
    });
    print('');
  }
}

Board board = Board();

void handleData(String data, EventSink<Board> sink) {
  if (data.length != 0) {
    board.addRow(data);
    if (board.board.length == board.size) {
      sink.add(board);
      board = Board();
    }
  }
}

List<Board> boardList = [];

void numCalled(String numStr) {
  int num = int.parse(numStr);
  List<Board> removed = [];
  boardList.forEach((board) {
    var rowCol = board.called(num);
    if (rowCol.length == 2) {
      bool bingo = board.isBingo(rowCol);
      if (bingo) {
        if (boardList.length == 1) {
          var sumOfUnmarked = board.sumOfUnmarked();
          print('sumOfUnmarked: ${sumOfUnmarked}');
          print('last num: ${numStr}');
          print('final result: ${num * sumOfUnmarked}');
          exit(0);
        } else {
          removed.add(board);
        }
      }
    }
  });

  removed.forEach((board) {
    boardList.remove(board);
  });
}

void main() async {
  const path = 'input.txt';
  var calledNums = await File(path)
      .openRead()
      .map(utf8.decode)
      .transform(new LineSplitter())
      .take(1)
      .toList();

  calledNums = calledNums[0].split(',');

  StreamTransformer<String, Board> transformer =
      StreamTransformer.fromHandlers(handleData: handleData);

  boardList = await File(path)
      .openRead()
      .map(utf8.decode)
      .transform(new LineSplitter())
      .skip(1)
      .transform<Board>(transformer)
      .toList();

  calledNums.forEach(numCalled);
  print(calledNums);
  boardList.forEach((board) {
    board.printBoard();
  });
}
