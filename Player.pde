class Player extends MobileEntity
{
  int lv;
  int exp;
  int hp;
  int maxHp;
  int mp;
  int maxMp;
  int atk;
  int def;
  
  Player(float x,float y)
  {
    lv = 1;
    exp = 0;
    posX=x;
    posY=y;
    hitBox=25;
    
    movementSpeed = 10;
  }
  
  void update()
  {
    fill(128);
    ellipse(posX,posY,50,50);
  }
  
  void move()
  {
    if (keys['W']&&posY>topBorder)
    {
      posY-=movementSpeed;
    }      
    if (keys['A']&&posX>sideBorder)
    {
      posX-=movementSpeed;
    }      
    if (keys['S']&&posY<height-topBorder)
    {
      posY+=movementSpeed;
    }      
    if (keys['D']&&posX<width-sideBorder)
    {
      posX+=movementSpeed;
    }      
  }


}
