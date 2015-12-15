ArrayList<Entity> ent = new ArrayList<Entity>();
boolean[] keys = new boolean[512];
PImage background;
float topBorder;
float sideBorder;

void setup()
{
  size(500,500);
  topBorder = height/8;
  sideBorder = width/8;
  
  Entity player1 = new Player();
  ent.add(player1);
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

