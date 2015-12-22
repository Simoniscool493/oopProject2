ArrayList<Entity> ent = new ArrayList<Entity>();
ArrayList<MonsterType> mon = new ArrayList<MonsterType>();

boolean[] keys = new boolean[512];
PImage background;
float topBorder;
float sideBorder;
char mode;
Battle b;

void setup()
{
  size(1000,1000);
  topBorder = height/8;
  sideBorder = width/8;
  textSize(30);
  
  makePlayer();
  
  loadMonsters();
  
  makeMonster(0);
  
  background = loadImage("wall1.png");
  mode = 'o';
}

void draw()
{
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
        b = new Battle((MonsterInstance)e);
        mode = 'b';
      }
    }
}

void loadMonsters()
{
  String[] monsters = loadStrings("monsters.csv");
  
  for(int i=0;i<monsters.length;i++)
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
    monster.overworldSprite = loadImage(monster.id+"ov.png");
    monster.battleSprite = loadImage(monster.id+"ba.png");
  }
}

void makeMonster(int id)
{
  Entity monster = new MonsterInstance(mon.get(id));
  ent.add(monster);
}


