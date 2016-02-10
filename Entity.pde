abstract class Entity
//abstract class for all entities on screen in the overworld
{
  PVector pos;
  float hitBox;
  PImage sprite;
  char type;
  //stores data on the type of entity, if it's a special entity or not, etc
  float h;
  float w;
  
  Entity() //if no position data is given, entity will spawn at a random spot in the dungeon
  {
    pos = new PVector(width/4*((int)random(3)+1),height/4*((int)random(3)+1));
  }
  
  Entity(float x,float y)
  {
    pos = new PVector(x,y);
  }
  
  Entity(PImage sp,float x,float y,char t)
  {
    pos = new PVector(x,y);
    sprite = sp;
    type = t;
    hitBox = sideBorder/2.5;
  }
  
  boolean isTouching(Entity e) //function for collision checking
  {
    if(pos.x+hitBox >= e.pos.x-e.hitBox && pos.x-hitBox <= e.pos.x+e.hitBox && pos.y+hitBox >= e.pos.y-e.hitBox && pos.y-hitBox <= e.pos.y+e.hitBox)
    {
      return true;
    }
    return false;
    
  }
  
  abstract void update();

}
