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
    
    speed = 10;
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
