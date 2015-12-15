class MonsterInstance extends MobileEntity
{
  int curHp;
  MonsterType template;
    
  MonsterInstance(MonsterType m)
  {
    template = m;
    sprite = m.overworldSprite;
    speed = 3;
  }
  
  void update()
  {
      image(template.overworldSprite,posX,posY);
  }
  
  void move()
  {
    posX+=speed;
    posY+=speed;
  }

}

