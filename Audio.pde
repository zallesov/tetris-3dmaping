
import processing.sound.*;

class Audio{

public SoundFile attach;
public SoundFile line;
public SoundFile[] voices;


  Audio(SoundFile[]voices_, SoundFile attach_, SoundFile line_){

    attach = attach_;
    line = line_;

    voices = voices_;
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