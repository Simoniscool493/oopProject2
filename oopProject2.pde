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

ArrayList<Entity> ent = new ArrayList<Entity>();
ArrayList<MonsterType> mon = new ArrayList<MonsterType>();
ArrayList<Room> rooms = new ArrayList<Room>();
ArrayList<PImage> backgrounds = new ArrayList<PImage>();
ArrayList<String> textBuffer = new ArrayList<String>();

boolean[] keys = new boolean[1024];
PImage background;
PImage title;

PImage topDoor;
PImage bottomDoor;
PImage leftDoor;
PImage rightDoor;

float topBorder;
float sideBorder;
char mode;

float introCircleSize = 0;
float introTitleHeight;

String name = new String();

// i = intro 
// o = overworld
// m = menu
// b = battle
// d = death
// w = win
// e = enter name

int menuPoint = 0;
boolean battleNext = false;
boolean next = false;
boolean newRoom = false;

Session s;
Battle b = new Battle();
Player p;
Room r;

void setup()
{  
  size(1000,1000);
  topBorder = height/8;
  sideBorder = width/8;
  textSize(height/33);
  
  s = new Session('i');
}

void enterName()
{
  background(0);
  fill(255);
  textSize(height/20);
  text(name,sideBorder,height/2);
  
  if(next)
  {
    next = false;
    p.name = name;
    intro.pause();
    overworld.loop();
    mode = 'o';
    textSize(height/33);
    textBuffer.add("Your name is " + name + ".");
    textBuffer.add("But there's another name that describes you.");
    textBuffer.add("That name is...");
    textBuffer.add("HERO.");
  }
}

void draw()
{ 
   if(mode == 'i')
   {
      playIntro();
   }
   else if(!showText() && textBuffer.isEmpty())
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
        menuPoint--;
      }
      if(key == 's')
      {
        menuPoint++;
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
  
  if(key == 'm' && mode == 'o')
  {
    r.makeMonster(r.monstersInRoom[(int)random(r.numTypeMonsters)]);
  }
  
  if(mode == 'e' && key != '\n' && key != '\t' && key != ' ' && textBuffer.isEmpty())
  {
    if(key == '\b')
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

void showMenu()
{
  float mappedHP = map(p.hp,0,p.maxHp,0,width*0.375);
  float mappedMP = map(p.mp,0,p.maxMp,0,width*0.375);

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

void doOverworld()
{
  if(textBuffer.isEmpty())
  {
    imageMode(CORNER);
    image(backgrounds.get(r.background),0,0,width,height);
    imageMode(CENTER);
  }
  
  if(!showText())
  {
   updateEntities();
   updatePlayer();
  }
}

boolean showText()
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

void updateEntities()
{
  for(Entity e:ent)
  {
    if(e instanceof MobileEntity)
    {
      ((MobileEntity)e).move();
    }
    
    e.update();
  
    if(e instanceof MonsterInstance && p.isTouching(e) && p.mercyInvincibility == 0)
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
    
    if(e.type > 10 && e.type < 53 && p.isTouching(e))
    {
      newRoom = true;
      p.mercyInvincibility = 5;
      r.changeRoom(e.type);
    }
  }
  
  if(newRoom)
  {
    r.clearMonsters();
    newRoom = false;
    r.makeMonsters();
  }
}
  
void gameOver()
{
  background(0);
  fill(255);
  text("GAME OVER",width/2-sideBorder,height/2);
  if(next)
  {
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

void updatePlayer()
{
  p.move();
  p.update();    
  
  if(p.mercyInvincibility>0)
  {
    p.mercyInvincibility--;
  }
}

void playIntro()
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

void winGame()
{
  background(255);
  fill(255,128,0);
  textAlign(CENTER);
  text("Congratulations! The Big Boss is no more!",width/2,height/2);
}

