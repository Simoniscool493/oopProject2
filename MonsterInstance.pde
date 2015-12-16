class MonsterInstance extends MobileEntity
{
  int curHp;
  MonsterType template;
    
  MonsterInstance(MonsterType m)
  {
    template = m;
    sprite = m.overworldSprite;
    movementSpeed = 3;
    hitBox = 30;
  }
  
  void update()
  {
      image(template.overworldSprite,posX,posY);
  }
  
  void move()
  {
    posX-=movementSpeed;
    posY+=movementSpeed;
  }

}

