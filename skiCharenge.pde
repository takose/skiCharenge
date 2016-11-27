
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

import processing.net.Client;
import processing.net.Server;
import java.awt.Event;
import java.awt.Button;

/*  Use Sprite  */
import sprites.utils.*;
import sprites.maths.*;
import sprites.*;

Server myServer;  /*  TCP Service*/
Minim minim;
Button StartBtn = new Button("Start");
AudioPlayer song;
Sprite SPoll;
Sprite SPlayer;

PImage BImg;

float Speed = 0.5;
long start = millis();
int Port = 81;
int PosX = 300;
int Play;
int Life = 0;
int LifeFlg = 0;
int X,Y;
int PSpeed = 5;
int Flg = 0;
int Score=0;

void setup(){
  size(700,700);
  BImg = loadImage("skiBackgnd2.jpg");
  SPlayer = new Sprite(this,"Player.png",1,1,50);
  SPlayer.setXY(width/2, 550);
  SPlayer.setVelXY(0.0f, 0);
  SPlayer.setDomain(0, 0, width, height, Sprite.HALT);
  SPlayer.setVisible(true);

  X = (int)random(200,300);
  SPoll =  new Sprite(this,"Pole2.png",1,1,10);
  SPoll.setXY(X, Y);
  SPoll.setVelXY(0.0f, 0);
  SPoll.setDomain(0, 0, width, height, Sprite.HALT);
  SPoll.setVisible(false);
  myServer = new Server(this, Port);
  add(StartBtn);
  minim = new Minim( this );
  song = minim.loadFile( "data/u.mp3" );
  background(BImg);
  ScoreDisp();
}

void ScoreDisp()
{
  noStroke();
  textSize(30);
  fill(#000000, 100);
  rect(0,0,700,80);
  fill(#EB0FF0);
  text("Score:"+Score+"\nLife:"+(3-Life),10,30);
  textSize(50);

  if(Life > 2){
    SPoll.setVisible(false);
    text("Game Over",240,50);
  }else {
    if(Flg == 1){
      text("→",X+30,50);  
    }else {
      text("←",X-30,50);
    }  
  }
}

//
void handleSpriteEvents(Sprite sprite) { 
  /* code */
}

void draw(){
  if(Play == 0){
    setUI();
  }
  else if(Play == 1){
    background(BImg);
    if (myServer != null) {
      ReceiveText();

      SPlayer.setXY(PosX,550);
      SPlayer.setVisible(true);
      println("PosX="+PosX);

      if(Y > 550 && Y < 650){
        if(Flg == 0 && X < PosX + 80){
          LifeFlg = 1;
        }else {
          Score++;
        }
        if(Flg == 1 && X > PosX){
          LifeFlg = 1;
        }else {
          Score++;
        }
      }
      ScoreDisp();
      SPoll.setXY(X,Y);
      if(int(millis() - start) == 7000){
        PSpeed += 1;
        start = 0;
      }
      Y += PSpeed;

      if(Y > height+50){
        Y = 0;
        if(LifeFlg==1){
          Life += 1;
          song.rewind();
          song.play();
          LifeFlg = 0;
          if(Life > 2){
            ScoreDisp();
            Play=0;
            Life = 0;
            StartBtn.show();
          }
        }
        if(Flg==0){
          X = (int)random(400,500);
          Flg = 1;
          fill(0);
        } else if(Flg == 1){
          X = (int)random(200,300);
          Flg = 0;
          fill(0);
        }
      }
    }
  }
  S4P.drawSprites();
  S4P.updateSprites(100);
}

void setUI(){
  StartBtn.setBounds(300,200,100,100);
}

boolean action(Event e,Object o){
  println(e);
  if(o.equals("Start")){
    Score=0;
    ScoreDisp();
    Play = 1;
    StartBtn.hide();
    SPoll.setVisible(true);
  }
  return true;
}
