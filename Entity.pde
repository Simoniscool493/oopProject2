abstract class Entity
{
  PVector pos;
  float hitBox;
  PImage sprite;
  char type;
  float h;
  float w;
  
  Entity()
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
  
  boolean isTouching(Entity e)
  {
    if(pos.x+hitBox >= e.pos.x-e.hitBox && pos.x-hitBox <= e.pos.x+e.hitBox && pos.y+hitBox >= e.pos.y-e.hitBox && pos.y-hitBox <= e.pos.y+e.hitBox)
    {
      return true;
    }
    return false;
    
  }
  
  void update()
  {
    image(sprite,pos.x,pos.y);   
  }
}
