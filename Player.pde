class Player extends MobileEntity
{
  String name;
  
  int lv;
  int exp;
  int expToLvUp;
  
  int hp;
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
    hitBox=25;
    mercyInvincibility = 0;
    
    maxHp = 10;
    hp = 10;
    maxMp = 10;
    mp = 10;
    atk = 5000000;
    def = 5;
    speed = 100;
    expToLvUp = 100;
    
    movementSpeed = 10;
  }
  
  void update()
  {
    fill(128);
    ellipse(pos.x,pos.y,50,50);
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
      maxHp+=5;
      expToLvUp = (lv*100);
    }
  }
  

}
