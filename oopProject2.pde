ArrayList<Entity> ent = new ArrayList<Entity>();
ArrayList<MonsterType> mon = new ArrayList<MonsterType>();

boolean[] keys = new boolean[512];
PImage background;
float topBorder;
float sideBorder;

void setup()
{
  size(1000,1000);
  topBorder = height/8;
  sideBorder = width/8;
  
  makePlayer();
  loadMonsters();
  
  makeMonster(0);
  
  background = loadImage("wall1.png");
}

void draw()
{
  background(147,91,62);
  
  image(background,0,0,width,height);
  for(Entity e:ent)
  {
    e.move();
    e.update();
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
    monster.overworldSprite = loadImage(monster.id+"ov.png");
  }
}

void makeMonster(int id)
{
  Entity monster = new MonsterInstance(mon.get(id));
  ent.add(monster);
}
