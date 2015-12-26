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
    curHp = template.hp-1;
  }
  
  void update()
  {
      image(sprite,posX,posY);
  }
  
  void move()
  {
    posX+=(movementSpeed*(random(1)));
    posX-=(movementSpeed*(random(1)));

    posY+=(movementSpeed*(random(1)));
    posY-=(movementSpeed*(random(1)));
  }

}

