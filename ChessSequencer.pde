import netP5.*; //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
import oscP5.*;
OscP5 oscP5;
NetAddress myRemoteLocation;

ArrayList<Square> Squares = new ArrayList<Square>();
ArrayList<ChessPiece> ChessPieces = new ArrayList<ChessPiece>();

String[] letter = {"A", "B", "C", "D", "E", "F", "G", "H"};
int[] OccupiedBoard = new int[64];

int selected;
int currentIndex;
ChessPiece current;

String startPos;
StringList posMoves;

void setup() {
  size(800, 800);

  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 8000);
  oscP5.plug(this, "result", "/test");

  color col = 0;
  for (int y = 0; y<8; y++) {
    for (int x = 0; x<8; x++) {

      // determining square object color
      if (y%2 == 1) {
        if (x%2 == 0) {
          col = color(118, 150, 86);
        } else {
          col = color(238, 238, 210);
        }
      } else {
        if (x%2 == 1) {
          col = color(118, 150, 86);
        } else {
          col = color(238, 238, 210);
        }
      }

      // defining the square objects
      int number = 9-(y+1);
      String lettern = letter[x];
      String textBoard = lettern + str(number);
      Square s = new Square(x*(width/8), y*(height/8), width/8, col, textBoard);
      Squares.add(s);

      // defining the chess pieces
      String pieceType = "null";
      color pieceColor = color(0);
      int player = 0;
      if (number == 7 || number == 2) {
        pieceType = "Pawn";
        pieceColor = color(255);
        if (y*(width/8) > width/2) {
          player = 0;
        } else { 
          player = 1;
        }
        ChessPiece piece = new ChessPiece(x*(width/8)+50, y*(height/8)+50, pieceColor, pieceType, textBoard, player);
        ChessPieces.add(piece);
      } 

      if (textBoard.equals("A1") || textBoard.equals("H1") || textBoard.equals("A8") || textBoard.equals("H8")) {
        pieceType = "Rook";
        pieceColor = color(250, 120, 100);
        if (y*(width/8) > width/2) {
          player = 0;
        } else { 
          player = 1;
        }
        ChessPiece piece = new ChessPiece(x*(width/8)+50, y*(height/8)+50, pieceColor, pieceType, textBoard, player);
        ChessPieces.add(piece);
      }

      if (textBoard.equals("B1") || textBoard.equals("G1") || textBoard.equals("B8") || textBoard.equals("G8")) {
        pieceType = "Knight";
        pieceColor = color(120, 255, 100);
        if (y*(width/8) > width/2) {
          player = 0;
        } else { 
          player = 1;
        }
        ChessPiece piece = new ChessPiece(x*(width/8)+50, y*(height/8)+50, pieceColor, pieceType, textBoard, player);
        ChessPieces.add(piece);
      }

      if (textBoard.equals("C1") || textBoard.equals("F1") || textBoard.equals("C8") || textBoard.equals("F8")) {
        pieceType = "Bishop";
        pieceColor = color(120, 120, 255);
        if (y*(width/8) > width/2) {
          player = 0;
        } else { 
          player = 1;
        }
        ChessPiece piece = new ChessPiece(x*(width/8)+50, y*(height/8)+50, pieceColor, pieceType, textBoard, player);
        ChessPieces.add(piece);
      }

      if (textBoard.equals("D1") || textBoard.equals("D8")) {
        pieceType = "Queen";
        pieceColor = color(200, 200, 120);
        if (y*(width/8) > width/2) {
          player = 0;
        } else { 
          player = 1;
        }
        ChessPiece piece = new ChessPiece(x*(width/8)+50, y*(height/8)+50, pieceColor, pieceType, textBoard, player);
        ChessPieces.add(piece);
      }

      if (textBoard.equals("E1") || textBoard.equals("E8")) {
        pieceType = "King";
        pieceColor = color(200, 250, 255);
        if (y*(width/8) > width/2) {
          player = 0;
        } else { 
          player = 1;
        }
        ChessPiece piece = new ChessPiece(x*(width/8)+50, y*(height/8)+50, pieceColor, pieceType, textBoard, player);
        ChessPieces.add(piece);
      }
    }
  }

  noLoop();
} 

void draw() {

  int indexS = 0;
  for (Square s : Squares) {
    s.show();
    //if (s.getposMove() == true) {
    //  println("hey! it worked! this is true for " + s.getText());
    //} 

    for (ChessPiece cp : ChessPieces) { //this loop is to check if the Square is occupied.
      s.occupied(cp);
    } //end of looping in ChessPieces

    OccupiedBoard[indexS] = s.getOccup();
    indexS++;
  } //end of looping in Squares


  //This loop is to draw pieces and to check what is the currently clicked piece.
  for (ChessPiece cp : ChessPieces) {
    cp.show();
    if (cp == current) {
      //current = null;
      cp.showMoves();
    }
  }
  /////////////////////////////////////////////////////////////Sending the Occupied Information via OSC.
  OscMessage myMessage = new OscMessage("/test");
  for (int index = 0; index < OccupiedBoard.length; index++) {
    myMessage.add(OccupiedBoard[index]);
  }
  oscP5.send(myMessage, myRemoteLocation);
  /////////////////////////////////////////////////////////////
  println();
  noLoop();
}

void mousePressed() {
  int indexn = 0;
  for (ChessPiece cp : ChessPieces) { //this loop is to determine the current chosen ChessPiece
    if (cp.inside() == true) {
      cp.highlight();
      selected = indexn;
      startPos = cp.getPos();
      cp.posMoves();
      posMoves = cp.getMoves();

      currentIndex = selected;
      current = ChessPieces.get(currentIndex);
      break;
    } else {
      cp.unhighlight();
      current = null;
    }
    indexn++;
  }

  if (current != null) {
    println("it is not null");
  }
  if (current == null) {
    println("it is null");
  }


  for (Square s : Squares) {
    String squareText = s.getText();

    //println("posMoves size is: " + posMoves.size());
    for (int j = 0; j < posMoves.size(); j++) {
      String posMoveN = posMoves.get(j);
      if (squareText.equals(posMoveN)) {
        s.possibleMove();
        j++;
        break;
      } else {
        s.notpossibleMove();
      }
    }

    if (s.getposMove() == true) {
      println(s.getText());
    }

    if (pmouseX < (s.getCenterX() + 50) && pmouseX > (s.getCenterX() - 50) && pmouseY < (s.getCenterY() + 50) && pmouseY > (s.getCenterY() - 50) && s.getposMove() == true) {
      println("user wants to move to " + s.getText());
      float choiceX = s.getCenterX();
      float choiceY = s.getCenterY();
      ChessPiece theChoice = ChessPieces.get(currentIndex);
      float cpX = theChoice.getX();
      float cpY = theChoice.getY();


      float moveX = s.getDistanceX(cpX);
      float moveY = s.getDistanceY(cpY);

      println("index of current piece is " + currentIndex);

      println("coordinates of Square center should be: ", choiceX, " ", choiceY);
      println("coordinates of current piece should be: ", cpX, " ", cpY);
      println("The move values should be", cpX-choiceX, " ", cpY-choiceY);

      if (s.getOccup() == 1) { //eating a piece
        for (int i = ChessPieces.size()-1; i <= 0; i--) {
          ChessPiece cpx = ChessPieces.get(i);
          
          if (s.getText().equals(cpx.getPos())) {
            ChessPieces.remove(i);
            println("index of current piece is " + currentIndex);
            println("remove " + s.getText() + " index is " + i);
          }
        }
        println("it is occupied");
      }
      
      ChessPieces.get(currentIndex).movetoNext(moveX, moveY);
      ChessPieces.get(currentIndex).updatePos(s.getText());
      //ChessPieces.get(currentIndex).update();
    }
  }

  redraw();
}
