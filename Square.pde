class Square {
  float x;
  float y;
  float centerX;
  float centerY;
  float size;
  color col;
  String text;
  int occup;
  boolean possibleMove;
  ChessPiece piece;
  

  Square(float _x, float _y, float _size, color _col, String _text) {
    x = _x;
    y = _y;
    centerX = _x + 50;
    centerY = _y + 50;
    size = _size;
    col = _col;
    text = _text;
    occup = 0;
    possibleMove = false;
  }
  
  String getText() {
    return text;
  }

  void show() {
    fill(col);
    stroke(255);
    strokeWeight(1);
    rect(x, y, size, size);

    fill(0);
    text(text, x+10, y+90);
    
    occup = 0;
  }

  void occupied(ChessPiece piece) {
    if (piece.getX()-50 == x && piece.getY()-50 == y) {
      occup = occup + 1;
    } else {
      occup = occup + 0;
    }
  }
  
  void possibleMove() {
    possibleMove = true;
  }
  
  void notpossibleMove() {
    possibleMove = false;
  }
  
  boolean getposMove() {
    return possibleMove;
  }
  
  float getCenterX() {
    return centerX;
  }
  
  float getCenterY() {
    return centerY;
  }
  
  float getDistanceX(float cpX) {
     float distanceX = centerX - cpX;
     println("add x ", distanceX);
     return distanceX;
  }
  
    float getDistanceY(float cpY) {
     float distanceY = centerY - cpY;
     println("add y ", distanceY);
     return distanceY;
  }
  
  int getOccup() {
    char letter = text.charAt(0);
    if (letter == 'H') {
      //println(occup);
      
    } else {
      //print(occup);
    }
    return occup;
  }
}
