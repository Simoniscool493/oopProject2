class Battle
{
  MonsterInstance enemy;
    
  String curBattleText;
  char[] buffer;
  boolean inMenu = false;
  int phase;
  int textDepth;
  int index;
  int damage;
  char turn = 's';
  char menu = 'n';
  
  // s = starting state
  // e = enemy turn
  // p = player turn
  // q = player action
  // f = enemy action

  String[] turnMenu = {"Attack","Magic","Item","Run"};
  String[] magicMenu = {"Fire","Freeze","Thunder","Heal"};
  
  float bSideBorder = sideBorder/2;
  float bTopBorder = topBorder/2;

  float mSideBorder = bSideBorder + sideBorder/8;
  float mTopBorder = bTopBorder + topBorder/8;
  
  float bMainMenuWidth = width-(bSideBorder*2);
  float bMainMenuHeight = height/3;
  
  Battle(MonsterInstance m,int ind)
  {
    enemy = m;
    index = ind;
    phase = 1;
    textDepth = 0;
    buffer = "#".toCharArray();
    curBattleText = "";
    menuPoint = 0;
  }

  void showBattleDetails()
  {
    background(255);
    fill(128);
    rect(bSideBorder,height-(height/3),width-(bSideBorder*2),height/3-bTopBorder);
    
    showOwnStats();
    showEnemyStats();
    
    text(phase,30,30);
    text(turn,50,30);
    text(textDepth,70,30);

    showBattleSprite();
    showBattleText();
    
    if(turn == 'p')
    {
      showMenu(turnMenu);
    }
  }
  
  void doBattle()
  {
     showBattleDetails();

      if(turn == 's')
      {
        startBattle();
      }
      
     if(turn == 'p')
     {
       if(battleNext)
       {
          battleNext = false;
          turn = 'q';
       }
     }
     
     if(turn == 'q')
     {
       {
         doSelected(menuPoint);
       }
     }
         
    if(turn == 'w')
    {
      winBattle();
    }
  }
 
  void startBattle()
  {
    battleText(enemy.template.battleStartText);
    if(battleNext)
    {
      curBattleText = " ";
      battleNext = false;
      if(enemy.template.speed>p.speed)
      {
        turn = 'e';
      }
      else
      {
        turn = 'p';
      }
    }
  }
  
  void winBattle()
  {
      if(textDepth==0)
      {
        sequentialText("You win!!",1);
      }
      if(textDepth==1)
      {
        if(sequentialText("You gained "+ enemy.template.exp +" exp. points",2))
        {
          p.expToLvUp-=enemy.template.exp;
          
          if(p.expToLvUp<1)
          {
            textDepth = 3;
          }
        }
      }
      if(textDepth==2)
      {
        mode = 'o';
        ent.remove(index);
      }
      if(textDepth==3)
      {
          p.levelUp();
      }
  }
    
  void doSelected(int sel)
  {
    
    if(menuPoint==0)
    {
      basicAttack();
    }
    if(menuPoint==1)
    {
      doMagic();
    }
    if(menuPoint==2)
    {
      useItem();
    }
    if(menuPoint==3)
    {
      run();
    }
  }
  
  void doMagic()
  {
    if(textDepth==0)
    {
      showMenu(magicMenu);
    }
  }
  
  void useItem()
  {
    
  }
  
  void run()
  {
    if(textDepth == 0)
    {
      sequentialText("You ran away",1);
    }
    if(textDepth == 1)
    {
      p.mercyInvincibility = 120;
      mode = 'o';
    }
  }

  void basicAttack()
  {
    if(textDepth==0)
    {
       if(sequentialText(p.name + " attacks!",1))
       {
         damage = (p.atk/enemy.template.def);
         if(damage<1)
         {
           damage=1;
         }
         if(damage>enemy.curHp)
         {
           enemy.curHp=0;
         }
         else
         {
           enemy.curHp-=damage;
         }
       }
    }
    if(textDepth==1)
    {
      sequentialText("you dealt a crazy "+ damage +" damage!",2);
    }
    if(textDepth==2)
    {
      if(enemy.curHp==0)
      {
        sequentialText("You know he dead",3);
      }
    }
    if(textDepth==3)
    {
      if(enemy.curHp==0)
      {
        turn = 'w';
      }
      else
      {
        turn = 'e';
      }
      
    textDepth = 0;
    }
  }
      
  void battleText(String s)
  {
      curBattleText = s;
  }
  
  boolean sequentialText(String s,int next)
  {

     battleText(s);
          
     if(battleNext)
     {
       battleNext=false;
       textDepth = next;
       
       return true;
     }
     
     return false;
  }
  
  void showBattleText()
  {    
     fill(0);
     text(curBattleText,sideBorder,height-(height/3)+topBorder/2);
  }
  
  void showOwnStats()
  {
     float mappedHP = map(p.hp,0,p.maxHp,0,width*0.36875);
     float mappedMP = map(p.mp,0,p.maxMp,0,width*0.36875);
     
     fill(128);
     rect(bSideBorder,topBorder/2,width/2.5,height/7);
     
     fill(0);
     text(p.name + " LV " + p.lv,sideBorder/2,topBorder/3);
     
     rect(mSideBorder,topBorder/2+topBorder/8,width*0.36875,height/21);
     fill(0,255,0);
     rect(mSideBorder,topBorder/2+topBorder/8,mappedHP,height/21);
     fill(0);
     rect(mSideBorder,topBorder/2+topBorder/4+height/21,width*0.36875,height/21);
     fill(0,0,255);
     rect(mSideBorder,topBorder/2+topBorder/4+height/21,mappedMP,height/21);
  }
  
  void showEnemyStats()
  {
     float mappedHP = map(enemy.curHp,0,enemy.template.hp,0,width*0.36875);

     fill(128);
     rect(width-sideBorder/2-width/2.5,topBorder/2,width/2.5,height/7);
     
     fill(0);
     text(enemy.template.name,width-sideBorder/2-width/2.5,topBorder/3);
     
     rect(width-sideBorder/2-width/2.5+sideBorder/8,topBorder/2+topBorder/8,width*0.36875,height/21);
     fill(0,255,0);
     rect(width-sideBorder/2-width/2.5+sideBorder/8,topBorder/2+topBorder/8,mappedHP,height/21);
  }
  
  
  void showMenu(String[] points)
  {
    int l = points.length;
    inMenu = true;
   
    if(menuPoint>l-1)
    {
      menuPoint=0;
    }
    if(menuPoint<0)
    {
      menuPoint=l-1;
    }
    
    fill(255);
    rect(mSideBorder,height-(height/3)+topBorder/8,width/3,height/3-topBorder/2-topBorder/4);
    fill(0);
    
    for(int i=0;i<l;i++)
    {
      text(points[i],sideBorder/2+sideBorder/3,height-(height/3)+topBorder/2-topBorder/10+(i*topBorder*0.36)+(topBorder*0.1));
    }
      
    ellipse(sideBorder/2-sideBorder/10+sideBorder/3,height-(height/3)+topBorder/2-topBorder/10+(menuPoint*topBorder*0.36),10,10);
    
  }
  
  void showBattleSprite()
  {
    image(enemy.template.battleSprite,width/2,height/2);
  }
}
