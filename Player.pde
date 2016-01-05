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
    lv = 3;
    exp = 0;
    posX=x;
    posY=y;
    hitBox=25;
    mercyInvincibility = 0;
    
    maxHp = 10;
    hp = 6;
    maxMp = 10;
    mp = 2;
    atk = 500;
    def = 5;
    speed = 100;
    expToLvUp = 100;
    
    movementSpeed = 10;
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
      posY-=movementSpeed;
    }      
    if (keys['A']&&posX>sideBorder)
    {
      posX-=movementSpeed;
    }      
    if (keys['S']&&posY<height-topBorder)
    {
      posY+=movementSpeed;
    }      
    if (keys['D']&&posX<width-sideBorder)
    {
      posX+=movementSpeed;
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
      expToLvUp = (lv*100);
    }
  }
  

}
