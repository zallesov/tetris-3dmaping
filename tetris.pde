import codeanticode.syphon.*;

import org.gamecontrolplus.gui.*;
import org.gamecontrolplus.*;
import net.java.games.input.*;

int WIDTH = 1024;
int HEIGHT = 768;
long GAME_TIME = 60*1000;
long VOICE_INTERVAL = 10*1000;
int MIN_WIN_SCORE = 0;


ControlIO control;
ControlDevice stick;

SyphonServer syphonServer;

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

Piece piece;
Board board;

Game game;
Audio audio;
int t1;

PImage menuImage; 

long gameStartTime = 0;
long voiceStartTime = 0;

int buttonPressThreshhold = 70;

boolean leftPressed;
long leftPressedLast;
boolean rightPressed;
long rightPressedLast;
boolean upPressed;
long upPressedLast;
boolean downPressed;
long downPressedLast;
boolean isMenu = true;


void settings() {
  size(WIDTH,HEIGHT, P3D);
  PJOGL.profile=1;
}

void loadSounds(){
  File[] filenames = listFiles("voices");
  SoundFile[] voices = new SoundFile[filenames.length];

  for(int i=0; i<filenames.length; i++){
    println(filenames[i].getAbsolutePath());
    voices[i] =  new SoundFile(this, filenames[i].getAbsolutePath());
  }

  audio = new Audio(voices,
    new SoundFile(this, "sounds/background.wav"),
    new SoundFile(this, "sounds/attach.wav"),
    new SoundFile(this, "sounds/line.wav"),
    new SoundFile(this, "sounds/win.wav"),
    new SoundFile(this, "sounds/gameOver.wav")
    ); //<>//

}

File[] listFiles(String dir) {
  File file = new File(sketchPath()+"/data/"+dir);
  if (file.isDirectory()) {
    File[] files = file.listFiles();
    return files;
  } else {
    return new File[0];
  }
}

void setup(){
  syphonServer = new SyphonServer(this, "Processing Syphon");
  
  loadSounds();
  audio.playBackground();

  menuImage = loadImage("menu.jpeg");

  font=loadFont("font.vlw");
  piece = new Piece(int(random(0,7 )),17,10,30,colors);
  board = new Board(15,8,30,colors);
  game = new Game(piece,board);

  noCursor();
  frameRate(600);
  //size(WIDTH,HEIGHT);
  
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

void attachBlock(){
  if(game.saveBoard()){
          audio.playEraseLine();  
        }else{
          audio.playBlockAttach();
        }
        piece.restart(int(random(0,7 )));
}

void updateGame(){
  if (millis()-t1>=game.velocity){
      t1=millis();
      if (game.validMove("DOWN")){
        piece.move("DOWN");
      }
      else{
        attachBlock();
      }
    }
}

void drawGameOver(){
  fill(255,0,0);
  textSize(30);
  text("Spiel Kaput",50,250);
  text(game.score+" Punkte",50,290);
}

boolean soundPlaying = false;
void playGameOver(){
  if(!soundPlaying){
    if(game.score >= MIN_WIN_SCORE){
      audio.playWin();
    }else{
      audio.playGameOver();
    }
    soundPlaying = true;
  }
}

void drawTimeIsUp(){
  fill(255,0,0);
  textSize(30);
  text("Time is up!",50,250);
  text(game.score+" Punkte",50,290);
}

void draw(){
  getUserInput();
  processKyes();
  
  background(0);
  if(isMenu){
    image(menuImage, 0,0);
  }else if(!game.isGameOver() && !game.isTimeIsUp()){
    updateGame();
    game.draw();
    checkGameTimeout();
    playVoiceIfNeeded();
  }else if(game.isGameOver()){
    drawGameOver();
    playGameOver();
  }else if(game.isTimeIsUp()){
    drawTimeIsUp();
    playGameOver();
  }
    
  syphonServer.sendScreen();

};

void checkGameTimeout(){
  if(millis() - gameStartTime > GAME_TIME){
    game.timeIsUp();
  }
}

void playVoiceIfNeeded(){
  if(millis() - voiceStartTime > VOICE_INTERVAL){
    voiceStartTime = millis();
    audio.playRandomVoice();
  }
}

void drop(){
  if(isMenu){
      isMenu = false;
  }else if (game.isGameOver()){
    restart();
  }else{ 
    while(game.validMove("DOWN")){
      piece.move("DOWN");
    }  
  }
}
  
void rotate(){
  if (game.validMove("ROTATE")){
      piece.rotate();
    }
  }
  
void restart(){
  gameStartTime = millis();
  game.restart();
  soundPlaying = false;
}

void processKyes() {
  if(!game.isGameOver() && !game.isTimeIsUp()){
    
      if (downPressed){
          if (game.validMove("DOWN")){
            piece.move("DOWN");
          }
          else{
            attachBlock();
          }
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