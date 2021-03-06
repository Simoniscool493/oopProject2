class MonsterInstance extends MobileEntity
//class for a specific instance of a monster
{
  int direction;
  int moveChoice;

  MonsterType template;
  //each monster instance has a template loaded randomly from monsters.csv
    
  MonsterInstance(MonsterType m)
  {
    template = m;
    direction = 0;
    sprite = m.sprite;
    movementSpeed = width/100;
    hp = template.hp;
    
    angle1 = random(10);
    angle2 = random(10);
    //initial angles for animation
    
    if(template.boss == 'y')
    {
      hitBox = width/5;
      h = width/2.5;
      w = width/2.5;
    }
    else
    {
      hitBox = width/24;
      h = width/12;
      w = width/12;
    }
  }
  
  void update() //monsters are animated as one large sphere with two smaller spheres spinning around it
  {
    float ball1X = pos.x + sin(angle1) * hitBox*1.5;
    float ball1Y = pos.y + cos(angle1) * hitBox*1.5;
    float ball2X = pos.x + sin(-angle2) * hitBox*1.5;
    float ball2Y = pos.y + cos(-angle2) * hitBox*1.5;

    strokeWeight(width/200);
    stroke(template.lineCol);
    fill(template.col);
    ellipse(pos.x,pos.y,w,h);
    line(pos.x-w/3,pos.y-h/3,pos.x+w/3,pos.y+h/3);
    line(pos.x+w/3,pos.y-h/3,pos.x-w/3,pos.y+h/3);
    strokeWeight(1);
    
    ellipse(ball1X,ball1Y,width/100,width/100);
    ellipse(ball2X,ball2Y,width/100,width/100);

    angle1+=(float)(direction+1)/20;
    angle2+=(float)(direction+1)/30;

    
  }

  void move() //monsters move randomly; sometimes they stay still. unpredictable.
  {
    if(template.boss == 'n')
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
  }
  
  void act()
  {
    if(b.turn=='e')
    {
      moveChoice = (int)random(5);
      b.turn = 'f';
    }
    else
    {
      if(moveChoice==0)
      {
        specialAttack();
      }
      else
      {
        basicAttack();
      }
    }
  }
  
  void basicAttack() //basic monster attack. does small damage.
  {
    if(b.textDepth==0)
    {
      b.animateAttack();
       if(b.sequentialText(template.name + " attacks!",1))
       {
          b.damage = (template.atk/p.def);
          b.damageEntity(p);
       }
    }
    if(b.textDepth==1)
    {
      if(b.sequentialText("you took "+ b.damage +" damage!",2))
      {
         b.nextTurn();
      }
    }
  }
  
  void specialAttack() //special monster attack. has unique animation and flavor text, and does higher damage.
  {
    if(b.textDepth==0)
    {
      b.animateAttack();
       if(b.sequentialText(template.specialAttack,1))
       {
          b.damage = (template.atk*2/p.def);
          b.damageEntity(p);
       }
    }
    if(b.textDepth==1)
    {
      if(b.sequentialText("you took a calamatious "+ b.damage +" damage!",2))
      {
         b.nextTurn();
      }
    }
  }
}

