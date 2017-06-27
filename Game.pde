
class Game{

  Piece piece;
  Board board;

  int rot;
  private boolean gameOver=false;
  private boolean timeIsUp=false;

  Game(Piece p, Board b){
    piece=p;
    board=b;
  }

  void draw(){
    board.draw();
    piece.draw();
    //score.draw();
  }

  boolean validMove(String w){
    if (w=="DOWN"){
      //Llego a tope en el borde inferior
      //if(piece.pivot[1]+2+piece.offset[piece.type][piece.rot][3]+1>=board.sizeY()+1) return false;

      for (int x=0;x<=4;x++){
        for (int y=0;y<=4;y++){
          if(piece.form[piece.type][piece.rot][y][x]!=0){
            if(x+piece.pivot[0]-2>=0 && y+piece.pivot[1]-2>=0 ){
              if(board.checkBlock(x+piece.pivot[0]-3,y+piece.pivot[1]-3+1)==false) return false;
            }
          }
        }
      }

    }

    if(w=="RIGHT"){
      //Que no salga del borde derecho
      if(piece.pivot[0]+2+piece.offset[piece.type][piece.rot][2]+1>=board.sizeX()+1) return false;

      for (int x=0;x<=4;x++){
        for (int y=0;y<=4;y++){
          if(piece.form[piece.type][piece.rot][y][x]!=0){
            if(x+piece.pivot[0]-3>=0 && y+piece.pivot[1]-3>=0 ){
              if(board.checkBlock(x+piece.pivot[0]-2,y+piece.pivot[1]-3)==false) return false;
            }
          }
        }
      }

    }

    if(w=="LEFT"){
      //Que no salga del borde izquierdo
      if(piece.pivot[0]-2-piece.offset[piece.type][piece.rot][0]-1<=0) return false;

      for (int x=0;x<=4;x++){
        for (int y=0;y<=4;y++){
          if(piece.form[piece.type][piece.rot][y][x]!=0){
            if(x+piece.pivot[0]-3>=0 && y+piece.pivot[1]-3>=0 ){
              if(board.checkBlock(x+piece.pivot[0]-4,y+piece.pivot[1]-3)==false) return false;
            }
          }
        }
      }

    }

    if(w=="ROTATE"){

      rot=piece.rot+1;
      if (rot>3){
        rot=0;
      }


      //Si sale de bordes
      if(piece.pivot[0]+2+piece.offset[piece.type][rot][2]>=board.sizeX()+1) return false;
      if(piece.pivot[0]-2-piece.offset[piece.type][rot][0]<=0) return false;



      //Si se encima
      for (int x=0;x<=4;x++){
        for (int y=0;y<=4;y++){
          if(piece.form[piece.type][rot][y][x]!=0){
            if(x+piece.pivot[0]-3>=0 && y+piece.pivot[1]-3>=0 ){
              if(board.checkBlock(x+piece.pivot[0]-3,y+piece.pivot[1]-3)==false) return false;
            }
          }
        }
      }
    }

    return true; 
  }

  boolean saveBoard(){
    for (int x=0;x<=4;x++){
      for (int y=0;y<=4;y++){
        if(piece.form[piece.type][piece.rot][y][x]!=0){
          if(!board.saveBlock(x+piece.pivot[0]-3,y+piece.pivot[1]-3,piece.type)) gameOver();
        }
      }
    }

    int linesErased = board.checkLines();
    linesUp(linesErased);

    return linesErased > 0;
  }

  int lines,levelLines=0,score=0,level=1,velocity=500;
  void linesUp(int l){
    lines+=l;
    score+=l*10;
    levelLines+=l;
    if(levelLines>=30){
      levelLines-=30;
      level++;
      velocity-=50;
    }
  }

  void gameOver(){
    gameOver=true;
  }
  void timeIsUp(){
    timeIsUp=true;
  }

  boolean isGameOver(){
    return gameOver;
  }

  boolean isTimeIsUp(){
    return timeIsUp;
  }

  void restart(){
    piece.restart(int(random(0,6)));
    board.restart();
    gameOver=false;
    timeIsUp=false; 

    lines=0;
    levelLines=0;
    score=0;
    level=1;
  }

}