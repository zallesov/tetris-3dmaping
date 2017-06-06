import processing.sound.*;

class juego{

  pieza piece;
  tablero board;
  marcador score;

  int rot;
  private boolean gameOver=false;

  juego(pieza p, tablero b, marcador s){
    piece=p;
    board=b;
    score=s;
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

  void saveBoard(){
    for (int x=0;x<=4;x++){
      for (int y=0;y<=4;y++){
        if(piece.form[piece.type][piece.rot][y][x]!=0){
          if(!board.saveBlock(x+piece.pivot[0]-3,y+piece.pivot[1]-3,piece.type)) gameOver();
        }
      }
    }
  }

  void gameOver(){
    gameOver=true;
  }

  boolean getStatus(){
    return gameOver;
  }

  void restart(){
    piece.restart(int(random(0,6)));
    score.restart();
    board.restart();
    gameOver=false;
  }

}