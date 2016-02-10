//oopProject2
//Simon O'Neill C14444108
//10-02-2016

import ddf.minim.*;

Minim minimIntro;
Minim minimBattle;
Minim minimOverworld;
Minim minimBoss;
Minim minimDeath;

AudioPlayer intro;
AudioPlayer battle;
AudioPlayer overworld;
AudioPlayer boss;
AudioPlayer death;

java.lang.Object sound_this = this;

//minim objects declared here, for playing the music
//sound_this holds the 'this' variable required to make minim work. it is used in the session class to load the music.

ArrayList<Entity> ent = new ArrayList<Entity>();
ArrayList<MonsterType> mon = new ArrayList<MonsterType>();
ArrayList<Room> rooms = new ArrayList<Room>();
ArrayList<PImage> backgrounds = new ArrayList<PImage>();
ArrayList<String> textBuffer = new ArrayList<String>();

//each arraylist has as purpose.
//ent holds all entities on screen.
//mon holds all monsters in the game.
//rooms holds all loaded rooms in the dungeon.
//backgrounds holds all backgrounds.
//textBuffer holds all text in the game outside battles.

boolean[] keys = new boolean[1024];
//keys is a boolean array used to scan for multiple keys at once. it's used to control the player's movement, allowing the player to move smoothly.

PImage title;
//the text on the title screen

PImage caveWall;

PImage topDoor;
PImage bottomDoor;
PImage leftDoor;
PImage rightDoor;
//the sprites of the doors

float topBorder;
float sideBorder;
//the established borders of the screen

float introCircleSize = 0;
float introTitleHeight;
//variables used for animating the intro

String name = new String();
//string holding the player name as it is entered in

char mode;
//each version of mode is a different state of the game.
// i = intro 
// o = overworld
// m = menu
// b = battle
// d = death
// w = win
// e = enter name

//
boolean battleNext = false;
boolean next = false;
boolean newRoom = false;
//flags that are used to control the flow of the program.

Session s;
Battle b = new Battle();
Player p;
Room r;
//declares the session, player, current room and current battle. battle is initialized to a blank battle to its variables can be accessed.

void setup()
{  
  size(1200,1200);
  topBorder = height/8;
  sideBorder = width/8;
  textSize(height/33);
  
  s = new Session('i');
  //starts the session by playing the intro
}

void enterName() //function to enter the player name
{
  background(0);
  fill(255);
  textSize(height/20);
  textAlign(CENTER);
  text("What is your name?",width/2,topBorder*2);
  textAlign(LEFT);
  text(name,sideBorder,height/2);
  textSize(height/33);
  text("(Press space when done)",sideBorder,height/1.5);
  
  if(next) //if statements like these will run the code in the statement when the space key is pressed
  {
    next = false;
    if(name.isEmpty())
    {
      p.name = "A Mystery";
    }
    else
    {
      p.name = name;
    }
    intro.pause();
    overworld.loop();
    mode = 'o';
    textSize(height/33);
    textBuffer.add("Your name is " + p.name + ".");
    textBuffer.add("But there's another word that describes you.");
    textBuffer.add("That word is...");
    textBuffer.add("HERO.");
  }
}

void draw()
{ 
   if(mode == 'i')
   {
      playIntro();
   }
   else if(!showText() && textBuffer.isEmpty()) // the game prioritizes showing any text in textBuffer over running any other code indraw
   {
     if(mode == 'e')
     {
       enterName();
     }
     if(mode == 'w')
     {
       winGame();
     } 
     if(mode == 'd')
     {
       gameOver(); 
     }
     if(mode == 'o')
     {
       doOverworld();
     }
     if(mode == 'b')
     {
       b.doBattle();    
     }
     if(mode == 'm')
     {
       showMenu();
     }
   }
      
  next = false;
}

void keyTyped()
{
  if(mode == 'b')
  {
    if(b.turn == 'p'||b.turn == 'r')
    {      
      if(key == 'w')
      {
        b.menuPoint--;
      }
      if(key == 's')
      {
        b.menuPoint++;
      }
    }
    
    if(key == ' ')
    {
      battleNext = true;
    }
  }
  
  if(key == 'e')
  {
    if(mode == 'o')
    {
      mode = 'm';
    }
  }
  
  if(key == 'q')
  {
    if(mode == 'm')
    {
       mode = 'o';
    }
  }
    
  if(key == ' ')
  {
    next = true;
  }
  
  if(mode == 'e' && key != '\n' && key != '\t' && key != ' ' && textBuffer.isEmpty()) //code to enter the player name
  {
    if(key == '\b')//takes one character from the name if backspace is pressed
    {
      if(name.length()>0)
      {
        name = name.substring(0,name.length()-1);
      }
    }
    else if(name.length() < 20)
    {
      name = name+key;
      println(key);
    }
  }
}

void showMenu() //shows the overworld menu
{
  textAlign(LEFT);
  float mappedHP = map(p.hp,0,p.maxHp,0,width*0.375);
  float mappedMP = map(p.mp,0,p.maxMp,0,width*0.375);
  //this code maps the current hp and mp to the two bars on the top of the screeen

  fill(128);
  rect(sideBorder,topBorder,width-sideBorder*2,height/2);
  
  fill(255);
  rect(sideBorder,topBorder/2,width*0.375,height/21);
  rect(width/2,topBorder/2,width*0.375,height/21);
 
  fill(0,255,0);
  rect(sideBorder,topBorder/2,mappedHP,height/21);
  fill(0,0,255);
  rect(width/2,topBorder/2,mappedMP,height/21);
  
  fill(0);
  text(p.name,sideBorder*1.5,topBorder*1.5);
  text("LV " + p.lv,sideBorder*1.5,topBorder*2);
  text("Atk: " + p.atk + "       Def: " + p.def + "       Spd: " + p.speed,sideBorder*1.5,topBorder*2.5);
  text("To next level: " + p.expToLvUp,sideBorder*1.5,topBorder*3);
  text(p.hp + "/" + p.maxHp,sideBorder*1.1,topBorder*0.75);
  text(p.mp + "/" + p.maxMp,width/2+sideBorder*0.1,topBorder*0.75);
}

void keyPressed()
{
  keys[keyCode] = true;
}

void keyReleased()
{
  keys[keyCode] = false;
}

void doOverworld() //code for running the overworld mode
{
  if(textBuffer.isEmpty()) //this if is here so that when the initial few lines of text is shown, the background will stay black.
  {
    imageMode(CORNER);
    //image(backgrounds.get(r.background),0,0,width,height);
    background(r.col);
    imageMode(CENTER);
  }
  
   updateEntities();
   updatePlayer();
   
   image(caveWall,width/2,height/2,width,height);
}

boolean showText() //code for showing text in the buffer
{
  if(textBuffer.isEmpty())
  {
    return false;
  }
  else
  {
    fill(128);
    rect(sideBorder,topBorder*5,width-sideBorder*2,topBorder*2);
    fill(0);
    text(textBuffer.get(0),sideBorder*1.4,topBorder*5.5);
    if(next)
    {
      textBuffer.remove(0);
    }
  }
  
  return true;
}

void updateEntities() //code that updates all entities except the player
{
  for(Entity e:ent)
  {
    if(e instanceof MobileEntity)
    {
      ((MobileEntity)e).move();
    }
    
    e.update();
  
    if(e instanceof MonsterInstance && p.isTouching(e) && p.mercyInvincibility == 0) //starts a battle if the player's touching a monster
    {
      b = new Battle((MonsterInstance)e,ent.indexOf(e));
      overworld.pause();
      if(((MonsterInstance)e).template.boss == 'y')
      {
        boss.loop();
      }
      else
      {
        battle.loop();
      }
      mode = 'b';
    }
    
    if(e.type > 10 && e.type < 53 && p.isTouching(e)) //changes room if the player's touching a door
    {
      newRoom = true;
      p.mercyInvincibility = 5;
      r.changeRoom(e.type);
    }
  }
  
  if(newRoom) //resets spawned monsters if the player's in a new room
  {
    r.clearMonsters();
    newRoom = false;
    r.makeMonsters();
  }
}
  
void gameOver() //shows the game over screen
{
  background(0);
  fill(255);
  textAlign(CENTER);
  text("GAME OVER",width/2,height/2);
  if(next) //exits the game over screen and brings the player back to the first room
  {
    r.clearMonsters();
    r = rooms.get(0);
    p.pos.x = width/2;
    p.pos.y = height/2;
    p.hp = p.maxHp;
    p.mp = p.maxMp;
    next = false;
    mode = 'o';
    death.pause();
    overworld.loop();
  }
}

void updatePlayer() //updates the player character
{
  p.move();
  p.update();    
  
  if(p.mercyInvincibility>0)
  {
    p.mercyInvincibility--;
  }
}

void playIntro() //plays the intro to the game
{
  fill(255);
  background(0);
  imageMode(CENTER);
  ellipse(width/2,height/2,introCircleSize,introCircleSize);
  image(title,width/2,height-introTitleHeight,width/1.2,height/10);
  
  if(introCircleSize<width/1.5)
  {
    introCircleSize+=5;
  }
  if(introTitleHeight<height/2)
  {
    introTitleHeight+=5;
  }
  
  if(next)
  {
    next = false;
    mode = 'e';
    background(0);
  }
}

void winGame() //congratulates player when game is won
{
  background(255);
  fill(255,128,0);
  textAlign(CENTER);
  text("Congratulations! The Big Boss is no more!",width/2,height/2);
}

