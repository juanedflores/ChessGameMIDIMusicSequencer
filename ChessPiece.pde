class ChessPiece {
  float x;
  float y;
  color col;
  color origCol;
  String type;
  String pos;
  int player;
  boolean inside;
  StringList posMoves;
  String[] letter = {"A", "B", "C", "D", "E", "F", "G", "H"};

  ChessPiece(float x_, float y_, color _col, String _type, String _pos, int _player) {
    x = x_;
    y = y_;
    col = _col;
    origCol = _col;
    type = _type;
    pos = _pos;
    player = _player;
    inside = false;
    posMoves = new StringList();
  }

  void show() {
    fill(col);
    strokeWeight(3);
    stroke(0);
    ellipse(x, y, 50, 50);
  }

  void highlight() {
    col = color(255, 255, 140);
  }

  void unhighlight() {
    col = origCol;
  }

  void updatePos(String newPos) {
    pos = newPos;
  }

  boolean inside() {
    if (pmouseY <= y + 25 && pmouseY >= y - 25 && pmouseX <= x + 25 && pmouseX >= x - 25) {
      inside = true;
      println("piece: " + pos + " " + type + " of player " + player +" has been clicked");
      return true;
    }
    inside = false;
    return false;
  }

  float getX() {
    return x;
  }

  float getY() {
    return y;
  }

  String getPos() {
    return pos;
  }

  void showMoves() {
    fill(200, 135, 190, 125);
    noStroke();

    /////////////////////////////////////////////////////////////
    if (type.equals("Pawn") && player == 0) {
      char letter = pos.charAt(1);
      if (letter == '2') {
        ellipse(x, y-100, 50, 50);
        ellipse(x, y-200, 50, 50);
      } else {
        ellipse(x, y-100, 50, 50);
      }
    }
    if (type.equals("Pawn") && player == 1) {
      char letter = pos.charAt(1);
      if (letter == '7') {
        ellipse(x, y+100, 50, 50);
        ellipse(x, y+200, 50, 50);
      } else {
        ellipse(x, y+100, 50, 50);
      }
    }
    /////////////////////////////////////////////////////////////
    if (type.equals("Rook")) {
      for (int i = 1; i < 8; i++) {
        ellipse(x, y+(i*100), 50, 50);
        ellipse(x, y-(i*100), 50, 50);
        ellipse(x+(i*100), y, 50, 50);
        ellipse(x-(i*100), y, 50, 50);
      }
    }
    /////////////////////////////////////////////////////////////
  }

  void posMoves() {
    posMoves.clear();

    /////////////////////////////////////////////////////////////
    if (type.equals("Pawn") && player == 0) {
      char start = pos.charAt(1);
      int number = int(pos.charAt(1)-48);
      if (start == '2') { //pawn is at starting position.
        for (int i = 1; i < 2; i++) {
          posMoves.append(pos.charAt(0)+str(number+1));
          posMoves.append(pos.charAt(0)+str(number+2));
        }
      } else {
        posMoves.append(pos.charAt(0)+str(number+1));
      }
    }

    if (type.equals("Pawn") && player == 1) {
      char start = pos.charAt(1);
      int number = int(pos.charAt(1)-48);
      if (start == '7') { //pawn is at starting position.
        for (int i = 1; i < 2; i++) {
          //int number = int(pos.charAt(1)-48);
          posMoves.append(pos.charAt(0)+str(number-1));
          posMoves.append(pos.charAt(0)+str(number-2));
        }
      } else {
        posMoves.append(pos.charAt(0)+str(number-1));
      }
    }
    /////////////////////////////////////////////////////////////
    if (type.equals("Rook")) {
      int number = int(pos.charAt(1)-48);
      for (int i = 1; i < 8; i++) {
        posMoves.append(pos.charAt(0)+str(constrain((int(number+i)), 1, 8)));
        posMoves.append(pos.charAt(0)+str(constrain((int(number-i)), 1, 8)));
      }

      for (int j = 0; j < letter.length; j++) {
        String letterx = letter[j];
        if (letterx.equals(str(pos.charAt(0))) == false) {
          posMoves.append(letterx + (number));
        }
      }
      println("posmoves size is " + posMoves.size());
      for (int k = 0; k < posMoves.size(); k++) {
        println("pos move " + k + " " + posMoves.get(k));
      }
      //posMoves.append("A" + (number));
      //posMoves.append("B" + (number));
      //posMoves.append("C" + (number));
      //posMoves.append("D" + (number));
      //posMoves.append("E" + (number));
      //posMoves.append("F" + (number));
      //posMoves.append("G" + (number));
      //posMoves.append("H" + (number));
      //println("number: " + number + " + i " + i + " equals: " + (number + i));
    }
    println("pos moves size is " + posMoves.size());
  }
  /////////////////////////////////////////////////////////////


  StringList getMoves() {
    return posMoves;
  }

  void movetoNext(float nX, float nY) {
    x = x + nX;
    println(" ");
    println("new x is: ", x);
    y = y + nY;
    println("new y is: ", y);
  }
}
