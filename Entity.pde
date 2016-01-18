abstract class Entity
{
  float posX;
  float posY;
  float hitBox;
  PImage sprite;
  
  Entity()
  {
    this(width/3,height/3);
  }
  
  Entity(float x,float y)
  {
    posX = x;
    posY = y;
  }
  
  Entity(PImage sp,float x,float y)
  {
    posX = x;
    posY = y;
    sprite = sp;
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
  
  void move()
  {
    
  }
  
}
