class MonsterInstance extends MobileEntity
{
  int hp;
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
         if(b.damage<1)
         {
           b.damage=1;
         }
         if(b.damage>p.hp)
         {
           p.hp=0;
         }
         else
         {
           p.hp-=b.damage;
         }
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

