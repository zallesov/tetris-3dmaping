import org.gamecontrolplus.gui.*;
import org.gamecontrolplus.*;
import net.java.games.input.*;

ControlIO control;
ControlDevice stick;

public color[] colors={
  color(255,0,0),
  color(0,0,255),
  color(155,39,240),
  color(247,255,44),
  color(20,230,247),
  color(255,179,57),
  color(0,255,0),
  color(120)
  };

  PFont font;

pieza piece;
tablero board;
marcador score;
juego game;
int t1;

int buttonPressThreshhold = 70;

boolean leftPressed;
long leftPressedLast;
boolean rightPressed;
long rightPressedLast;
boolean upPressed;
long upPressedLast;
boolean downPressed;
long downPressedLast;

void setup(){

  font=loadFont("font.vlw");
  piece = new pieza(int(random(0,7 )),17,10,30,colors);
  board = new tablero(15,8,30,colors);
  score = new marcador(font);
  game = new juego(piece,board,score);

  noCursor();
  frameRate(600);
  size(240,450);
  
  control = ControlIO.getInstance(this);
  
  stick = control.getMatchedDevice("joystick");
  if (stick == null) {
    println("No suitable device configured");
    System.exit(-1); // End the program NOW!
  }
  stick.getButton("A").plug(this, "rotate", ControlIO.ON_RELEASE);
  stick.getButton("B").plug(this, "drop", ControlIO.ON_RELEASE);
  stick.getButton("START").plug(this, "restart", ControlIO.ON_RELEASE);
  
  background(0);
  board.draw();

  leftPressedLast = millis();
};

public void getUserInput() {
  float px = stick.getSlider("X").getValue();
  if(px == -1 && millis() - leftPressedLast > buttonPressThreshhold * 1.5 ){
    leftPressedLast = millis();
    leftPressed = true;
  }else{
    leftPressed = false;
  }
  
  if(px == 1 && millis() - rightPressedLast > buttonPressThreshhold * 1.5 ){
    rightPressedLast = millis();
    rightPressed = true;
  }else{
    rightPressed = false;
  }
  
  float py = stick.getSlider("Y").getValue();
  if(py == -1 && millis() - upPressedLast > buttonPressThreshhold ){
    upPressedLast = millis();
    upPressed = true;
  }else{
    upPressed = false;
  }
  
  if(py == 1 && millis() - downPressedLast > buttonPressThreshhold ){
    downPressedLast = millis();
    downPressed = true;
  }else{
    downPressed = false;
  }
}

void draw(){
  getUserInput();
  processKyes();
  
  background(0);
  game.draw();

  if(!game.getStatus()){

    //Baja automaticamente la pieza
    if (millis()-t1>=score.vel){
      t1=millis();
      if (game.validMove("DOWN")){
        piece.move("DOWN");
      }
      else{
        game.saveBoard();
        score.linesUp(board.checkLines());
        piece.restart(int(random(0,7 )));
      }
    }
  }
  else{
    fill(255,0,0);
    textSize(70);
    text("Game Over",50,250);
    text("Score",50,290);
    text(score.lines,40,300);
  }


};

void drop(){
  while(game.validMove("DOWN")){
    piece.move("DOWN");
  }  
  }
  
void rotate(){
  if (game.validMove("ROTATE")){
      piece.rotate();
    }
  }
  
void restart(){
    game.restart();
  }
 

void processKyes() {

  println(keyCode);
  println(key);
  
  if(!game.getStatus()){
    
      if (downPressed){
        //if (millis()-t1>=1){
        //  t1=millis();
          if (game.validMove("DOWN")){
            piece.move("DOWN");
          }
          else{
            game.saveBoard();
            score.linesUp(board.checkLines());
            piece.restart(int(random(0,7 )));
          }
        //}
      }
     
      if (leftPressed){
        if (game.validMove("LEFT")){
          piece.move("LEFT");
        }
      }
      if (rightPressed){
        if (game.validMove("RIGHT")){
          piece.move("RIGHT");
        }
      }
      
  
  }
}