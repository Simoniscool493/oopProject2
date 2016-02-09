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
    hp = 1;
    maxMp = 10;
    mp = 0;
    atk = 5;
    def = 5;
    speed = 100;
    expToLvUp = 100;
    
    movementSpeed = width/80;
  }
  
  void update()
  {
    float ball1X = pos.x + sin(angle1) * hitBox*1.5;
    float ball1Y = pos.y + cos(angle1) * hitBox*1.5;
    float ball2X = pos.x + sin(-angle1) * hitBox*1.5;
    float ball2Y = pos.y + cos(-angle1) * hitBox*1.5;
    
    int mappedHealth = (int)map(p.hp,0,p.maxHp,0,255);
    int mappedMagic = (int)map(p.mp,0,p.maxMp,0,255);
    
    println(mappedMagic);


    fill(255);
    ellipse(pos.x,pos.y,width/20,width/20);
    
    fill(255,255,0);
    ellipse(pos.x,pos.y,width/25,width/25);
    
    fill(255,127,0);
    ellipse(pos.x,pos.y,width/40,width/40);
   
    fill(0,mappedHealth,0);
    ellipse(ball1X,ball1Y,width/80,width/80);
    fill(255-mappedMagic,255-mappedMagic,255);
    ellipse(ball2X,ball2Y,width/80,width/80);
    
    angle1+=0.1;

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
