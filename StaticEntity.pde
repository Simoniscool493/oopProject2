class StaticEntity extends Entity
{
  StaticEntity()
  {
    super();
  }
 
  StaticEntity(float x,float y)
  {
    super(x,y);
  }
  
  StaticEntity(PImage sp,float x,float y)
  {
    super(sp,x,y);
  }

  void update()
  {
    image(sprite,posX,posY);   
  }
  
  void move()
  {
  }

}
