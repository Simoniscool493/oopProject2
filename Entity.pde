abstract class Entity
{
  float posX;
  float posY;
  float hitBox;
  PImage sprite;
  char type;
  
  Entity()
  {
    this(width/3,height/3);
  }
  
  Entity(float x,float y)
  {
    posX = x;
    posY = y;
  }
  
  Entity(PImage sp,float x,float y,char t)
  {
    posX = x;
    posY = y;
    sprite = sp;
    type = t;
    hitBox = sideBorder/2.5;
  }
  
  boolean isTouching(Entity e)
  {
    if(posX+hitBox >= e.posX-e.hitBox && posX-hitBox <= e.posX+e.hitBox && posY+hitBox >= e.posY-e.hitBox && posY-hitBox <= e.posY+e.hitBox)
    {
      return true;
    }
    return false;
    
  }
  
  void update()
  {
    image(sprite,posX,posY);   
  }
  
}
