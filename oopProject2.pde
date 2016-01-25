ArrayList<Entity> ent = new ArrayList<Entity>();
ArrayList<MonsterType> mon = new ArrayList<MonsterType>();
ArrayList<Room> rooms = new ArrayList<Room>();
ArrayList<PImage> backgrounds = new ArrayList<PImage>();

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

// i = intro 
// o = overworld
// m = menu
// b = battle
// d = death

int menuPoint = 0;
boolean battleNext = false;
boolean next = false;
boolean newRoom = false;

Battle b = new Battle();
Player p;
Room r;

void setup()
{  
  size(1000,1000);
  topBorder = height/8;
  sideBorder = width/8;
  textSize(height/33);
    
  makePlayer();
  loadMonsters();
  loadSprites();
  initializeRoom();
  
  makeDoors();
  
  mode = 'i';
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
    
  text(r.locX + " " + r.locY, sideBorder,topBorder);
  
  next = false;
}

void initializeRoom()
{
  r = new Room(0,0);
  r.background = 0;
  r.makeMonsters();
  rooms.add(r);
}

void clearMonsters()
{
  int size = ent.size();
  int i = 0;
 
  while(i<ent.size())
  {
    if(ent.get(i) instanceof MonsterInstance)
    {
      ent.remove(i);
    }
    else
    {
      i++;
    }
  }
}

void loadSprites()
{
  title = loadImage("title.png");
  
  topDoor = loadImage("doors/topDoor.png");
  bottomDoor = loadImage("doors/bottomDoor.png");
  leftDoor = loadImage("doors/leftDoor.png");
  rightDoor = loadImage("doors/rightDoor.png");
  
  loadBackgrounds();
}

void loadBackgrounds()
{
  boolean more = true;
  int i = 0;
  
  while(more)
  {
    PImage b = loadImage("background" + i + ".png");
    if(b != null)
    {
      backgrounds.add(b);
      i++;
    }
    else
    {
      more = false;
    }
  }
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
  image(backgrounds.get(r.background),0,0,width,height);
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
    
    if(e.type > 10 && e.type < 53 && p.isTouching(e))
    {
      newRoom = true;
      p.mercyInvincibility = 10;
      changeRoom(e.type);
    }
  }
  
  if(newRoom)
  {
    clearMonsters();
    newRoom = false;
    r.makeMonsters();
  }
}

void changeRoom(char c)
{
  if(c == '1')
  {
    tryRoom(0,-1);
  }
  else if(c == '2')
  {
    tryRoom(0,1);
  }
  else if(c == '3')
  {
    tryRoom(-1,0);
  }
  else if(c == '4')
  {
    tryRoom(1,0);
  }
}

void tryRoom(int x,int y)
{
  boolean used = false;
  for(Room rm:rooms)
  {
    if(rm.locX == r.locX+x && rm.locY == r.locY+y && !used)
    {
      r = rm;
      used = true;
    }      
  }
  
  if(!used)
  {
    Room room = new Room(r.locX+x,r.locY+y);
    rooms.add(room);
    r = room;
  }
  
  relocatePlayer(x,y); 
}

void relocatePlayer(int x,int y)
{
  if(x == 1)
  {
    p.pos.x = sideBorder*1.2;
    p.pos.y = height/2;
  }
  else if(x == -1)
  {
    p.pos.x = width-sideBorder*1.2;
    p.pos.y = height/2;
  }
  else if(y == 1)
  {
    p.pos.x = width/2;
    p.pos.y = topBorder*1.2;
  }
  else if(y == -1)
  {
    p.pos.x = width/2;
    p.pos.y = height-topBorder*1.2;
  }
}
  

void makeDoors()
{
  StaticEntity td = new StaticEntity(topDoor,width/2,topBorder/2,'1');
  StaticEntity bd = new StaticEntity(bottomDoor,width/2,height-topBorder/2,'2');
  StaticEntity ld = new StaticEntity(leftDoor,sideBorder/2,height/2,'3');
  StaticEntity rd = new StaticEntity(rightDoor,width-sideBorder/2,height/2,'4');
  ent.add(td);
  ent.add(bd);
  ent.add(ld);
  ent.add(rd);
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
    makeMonster(r.monstersInRoom[(int)random(r.numTypeMonsters)]);
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
    mode = 'o';
  }
}
