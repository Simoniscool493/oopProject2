class StaticEntity extends Entity
{
  StaticEntity()
  {
  }
  
  StaticEntity(float x,float y)
  {
    posX = x;
    posY = y;
  }
  
  StaticEntity(PImage sp,float x,float y)
  {
    posX = x;
    posY = y;
    sprite = sp;
  }

  void update()
  {
    image(sprite,posX,posY);   
  }
  
  void move()
  {
  }

}
