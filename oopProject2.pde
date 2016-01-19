ArrayList<Entity> ent = new ArrayList<Entity>();
ArrayList<MonsterType> mon = new ArrayList<MonsterType>();
ArrayList<Room> rooms = new ArrayList<Room>();
ArrayList<PImage> backgrounds = new ArrayList<PImage>();

boolean[] keys = new boolean[512];
PImage background;
PImage title;

PImage topDoor;
PImage bottomDoor;
PImage leftDoor;
PImage rightDoor;

float topBorder;
float sideBorder;
char mode;

float introCircleSize;
float introTitleHeight;

// i = intro 
// o = overworld
// m = menu
// b = battle
// d = death

int menuPoint = 0;
boolean battleNext = false;
boolean next = false;

Battle b = new Battle();
Player p;
Room r;

void setup()
{  
  size(1000,1000);
  topBorder = height/8;
  sideBorder = width/8;
  textSize(height/33);
  
  introCircleSize = 0;
  
  makePlayer();
  loadMonsters();
  loadSprites();
  initializeRoom();
  
  makeDoors();
  
  mode = 'i';
}

void initializeRoom()
{
  r = new Room(0,0);
  rooms.add(r);
  r.makeMonsters();
}

void loadSprites()
{
  title = loadImage("title.png");
  background = loadImage("wall1.png");
  
  topDoor = loadImage("doors/topDoor.png");
  bottomDoor = loadImage("doors/bottomDoor.png");
  leftDoor = loadImage("doors/leftDoor.png");
  rightDoor = loadImage("doors/rightDoor.png");
}

void draw()
{   
  if(mode == 'd')
  {
    gameOver();
  }
  if(mode == 'i')
  {
    playIntro();
  }
  if(mode == 'o')
  {
    doOverworld();
  }
  else if(mode == 'b')
  {
    b.doBattle();    
  }
  if(mode == 'm')
  {
    showMenu();
  }
  
  next = false;
}

void showMenu()
{
  fill(128);
  rect(sideBorder,topBorder,width-sideBorder*2,height-topBorder*2);
  fill(0);
  text(p.name + " LV " + p.lv,sideBorder*1.5,topBorder*1.5);
  text("Atk: " + p.atk + "       Def: " + p.def + "       Spd: " + p.speed,sideBorder*1.5,topBorder*2);
  text("To next level: " + p.expToLvUp,sideBorder*1.5,topBorder*2.5);
}

void keyPressed()
{
  keys[keyCode] = true;
}

void keyReleased()
{
  keys[keyCode] = false;
}

void makePlayer()
{
  p = new Player(width/2,height/2);
}

void doOverworld()
{
    imageMode(CORNER);
    background(147,91,62);
    image(background,0,0,width,height);
    imageMode(CENTER);

    updateEntities();
    updatePlayer();
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
      mode = 'b';
    }
    if(e.type == 'd' && p.isTouching(e))
    {
      print("door");
    }

  }
}

void gameOver()
{
  background(0);
  fill(255);
  text("GAME OVER",width/2-sideBorder,height/2);
  if(next)
  {
    p.hp = p.maxHp;
    p.mp = p.maxMp;
    next = false;
    mode = 'o';
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

void loadMonsters()
{
  String[] monsters = loadStrings("monsters.csv");
  
  for(int i=1;i<monsters.length;i++)
  {
    MonsterType monster = new MonsterType();
    mon.add(monster);
    
    String[] buffer = split(monsters[i],',');
    
    monster.id = parseInt(buffer[0]);
    monster.name = buffer[1];
    monster.hp = parseInt(buffer[2]);
    monster.atk = parseInt(buffer[3]);
    monster.def = parseInt(buffer[4]);
    monster.speed = parseInt(buffer[5]);
    monster.battleStartText = buffer[6];
    monster.exp = parseInt(buffer[7]);
    monster.overworldSprite = loadImage(monster.id+"ov.png");
    monster.battleSprite = loadImage(monster.id+"ba.png");
  }
}

void makeMonster(int id)
{
  Entity monster = new MonsterInstance(mon.get(id));
  ent.add(monster);
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
  
  if(key == 'm')
  {
    makeMonster((int)random(3));
  }
}

void makeDoors()
{
  StaticEntity td = new StaticEntity(topDoor,(float)width/2,topBorder/2,'d');
  StaticEntity bd = new StaticEntity(bottomDoor,width/2,height-topBorder/2,'d');
  StaticEntity ld = new StaticEntity(leftDoor,sideBorder/2,height/2,'d');
  StaticEntity rd = new StaticEntity(rightDoor,width-sideBorder/2,height/2,'d');
  ent.add(td);
  ent.add(bd);
  ent.add(ld);
  ent.add(rd);
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
    mode = 'o';
  }
}
