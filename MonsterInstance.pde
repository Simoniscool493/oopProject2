class MonsterInstance extends FightingEntity
{
  int direction;
  MonsterType template;
    
  MonsterInstance(MonsterType m)
  {
    template = m;
    direction = 0;
    sprite = m.overworldSprite;
    movementSpeed = 10;
    hitBox = 30;
    hp = template.hp;
  }
  
  void update()
  {
    image(sprite,pos.x,pos.y);
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
      if(pos.y<height-topBorder)
      {
        pos.y+=movementSpeed;
      }
    }
    if(direction == 2)
    {
      if(pos.x>sideBorder)
      {
        pos.x-=movementSpeed;
      }
    }
    if(direction == 3)
    {
      if(pos.x<width-sideBorder)
      {
        pos.x+=movementSpeed;
      }
    }
    if(direction == 4)
    {
      if(pos.y>topBorder)
      {
        pos.y-=movementSpeed;
      }
    }
  }
  
  void act()
  {
    basicAttack();
  }
  
  void basicAttack()
  {
    if(b.textDepth==0)
    {
       if(b.sequentialText(template.name + " attacks!",1))
       {
         b.damage = (template.atk/p.def);
         b.damageEntity(p);
        }
    }
    if(b.textDepth==1)
    {
      b.sequentialText("you took a calamatious "+ b.damage +" damage!",2);
    }
    if(b.textDepth==2)
    {
      b.battleText(" ");
      b.turn = 'p';
      b.textDepth = 0;
    }
  }
}

