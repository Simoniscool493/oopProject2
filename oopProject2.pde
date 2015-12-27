ArrayList<Entity> ent = new ArrayList<Entity>();
ArrayList<MonsterType> mon = new ArrayList<MonsterType>();

boolean[] keys = new boolean[512];
PImage background;
PImage title;
float topBorder;
float sideBorder;
char mode;

float circleSize;
float titleHeight;

// i = intro 
// o = overworld
// m = menu
// b = battle

int menuPoint = 0;
boolean battleNext = false;
boolean next = false;

Battle b;

void setup()
{
  size(1000,1000);
  topBorder = height/8;
  sideBorder = width/8;
  textSize(height/33);
  
  circleSize = 0;
  
  makePlayer();
  loadMonsters();
    
  makeMonster(2);
  b = new Battle((MonsterInstance)ent.get(1),1);

  title = loadImage("title.png");
  background = loadImage("wall1.png");
  mode = 'i';
}

void draw()
{  
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
  Entity player1 = new Player(width/2,height/2);
  ent.add(player1);
}

void doOverworld()
{
    imageMode(CORNER);
    background(147,91,62);
    image(background,0,0,width,height);
    imageMode(CENTER);
    for(Entity e:ent)
    {
      e.move();
      e.update();
  
      if(e instanceof MonsterInstance && (ent.get(0)).isTouching(e))
      {
        b = new Battle((MonsterInstance)e,ent.indexOf(e));
        mode = 'b';
      }
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
    if(b.turn == 'p')
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
  
  if(key == ' ')
  {
    next = true;
  }
  
  if(key == 'm')
  {
    makeMonster(2);
  }
}

void playIntro()
{
  fill(255);
  background(0);
  imageMode(CENTER);
  ellipse(width/2,height/2,circleSize,circleSize);
  image(title,width/2,height-titleHeight);
  
  if(circleSize<width/1.5)
  {
    circleSize+=5;
  }
  if(titleHeight<height/2)
  {
    titleHeight+=5;
  }
  
  
  if(next)
  {
    next = false;
    mode = 'o';
  }
}
