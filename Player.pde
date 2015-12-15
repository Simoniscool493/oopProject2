class Player extends Entity
{
  Player()
  {
    posX=width/2;
    posY=height/2;
    
    speed = 5;
  }
  
  void update()
  {
    fill(128);
    ellipse(posX,posY,50,50);
    //println(posY);
  }
  
  void move()
  {
    if (keys['W']&&posY>topBorder)
    {
      posY-=speed;
    }      
    if (keys['A']&&posX>sideBorder)
    {
      posX-=speed;
    }      
    if (keys['S']&&posY<height-topBorder)
    {
      posY+=speed;
    }      
    if (keys['D']&&posX<width-sideBorder)
    {
      posX+=speed;
    }      
  }


}
