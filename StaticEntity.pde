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
  
  StaticEntity(PImage sp,float x,float y,char t)
  {
    super(sp,x,y,t);
  }

  void update()
  {
    image(sprite,pos.x,pos.y,height/10,width/10);   
  }
  
  void move()
  {
  }

}
