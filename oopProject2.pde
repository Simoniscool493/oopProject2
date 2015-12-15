ArrayList<Entity> ent = new ArrayList<Entity>();
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
