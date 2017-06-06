class marcador{

  private PFont font;
  int lines,linesAux=0,score=0,level=1,vel=500;

  marcador(PFont f){
    font=f;
  }

  void draw(){
    textSize(30);
    fill(255);
    text("Tetris :e",340,20);
    text("Puntos",340,80);
    text(score,340,140);
    text("Lineas",340,200);
    text(lines,340,260);
    text("Nivel",340,320);
    text(level,340,380);
  }

  private void scoreUp(int l){
    score+=l*10;
  }

  void linesUp(int l){
    lines+=l;
    scoreUp(l);
    linesAux+=l;
    if(linesAux>=30){
      linesAux-=30;
      levelUp();
    }
  }

  private void levelUp(){
    level++;
    vel-=50;
  }

  void restart(){
lines=0;
linesAux=0;
score=0;
level=1;
  }

}