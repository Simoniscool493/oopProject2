class Player extends MobileEntity
{
  String name;
  
  int lv;
  int exp;
  int expToLvUp;
  
  int maxHp;
  
  int mp;
  int maxMp;
  
  int atk;
  int def;
  int speed;
  
  int mercyInvincibility;
  
  Player(float x,float y)
  {
    name = "Bob";
    lv = 1;
    exp = 0;
    pos.x=x;
    pos.y=y;
    hitBox=width/40;
    mercyInvincibility = 0;
    
    maxHp = 10;
    hp = 10;
    maxMp = 10;
    mp = 10;
    atk = 5000;
    def = 5;
    speed = 100;
    expToLvUp = 100;
    
    movementSpeed = width/80;
  }
  
  void update()
  {
    fill(255);
    ellipse(pos.x,pos.y,width/20,width/20);
  }
  
  void move()
  {
    if (keys['W']&&pos.y>topBorder)
    {
      pos.y-=movementSpeed;
    }      
    if (keys['A']&&pos.x>sideBorder)
    {
      pos.x-=movementSpeed;
    }      
    if (keys['S']&&pos.y<height-topBorder)
    {
      pos.y+=movementSpeed;
    }      
    if (keys['D']&&pos.x<width-sideBorder)
    {
      pos.x+=movementSpeed;
    }      
  }

  void levelUp()
  {
    if(b.sequentialText(p.name + " grew to level " + (p.lv+1) + "!",2))
    {
      lv++;
      atk+=5;
      def+=5;
      speed+=5;
      hp+=5;
      maxHp+=5;
      mp+=2;
      maxMp+=2;
      expToLvUp = (lv*100);
    }
  }
  

}
