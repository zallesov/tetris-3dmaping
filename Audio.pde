
import processing.sound.*;

class Audio{

public SoundFile attach;
public SoundFile line;
public SoundFile background;
public SoundFile win;
public SoundFile gameOver;
public SoundFile[] voices;

private boolean isGameOverPlaying = false;


  Audio(SoundFile[]voices_, 
    SoundFile background_, 
    SoundFile attach_, 
    SoundFile line_, 
    SoundFile win_,
    SoundFile gameOver_){

    attach = attach_;
    line = line_;
    background = background_;
    win = win_;
    gameOver = gameOver_;
    voices = voices_;
  }

  void playBackground(){
    background.loop();
    background.amp(0.05);
  }

  void stopBackground(){
    background.stop();
  }

  void playWin(){
    win.play();
  }

  void playGameOver(){
      gameOver.play();
  }

  void playEraseLine(){
    line.play();
  }

  void playBlockAttach(){
    attach.play();
  }

  void playRandomVoice(){
    for (int i = 0; i < voices.length; i++) {
      voices[i].stop();
    }

    int randomVoice = (int) random(voices.length);
    voices[randomVoice].play();
  }
}