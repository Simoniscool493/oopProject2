class MonsterInstance extends MobileEntity
{
  int curHp;
  int direction;
  MonsterType template;
    
  MonsterInstance(MonsterType m)
  {
    template = m;
    direction = 0;
    sprite = m.overworldSprite;
    movementSpeed = 10;
    hitBox = 30;
    curHp = template.hp-1;
  }
  
  void update()
  {
      image(sprite,posX,posY);
  }
  
  void move()
  {
    if((int)random(20)==0)
    {
      direction = (int)random(5);
    }
    
    if(direction == 0)
    {
    }
    if(direction == 1)
    {
      if(posY<height-topBorder)
      {
        posY+=movementSpeed;
      }
    }
    if(direction == 2)
    {
      if(posX>sideBorder)
      {
        posX-=movementSpeed;
      }
    }
    if(direction == 3)
    {
      if(posX<width-sideBorder)
      {
        posX+=movementSpeed;
      }
    }
    if(direction == 4)
    {
      if(posY>topBorder)
      {
        posY-=movementSpeed;
      }
    }
  }

}

