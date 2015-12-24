class Battle
{
  MonsterInstance enemy;
  String curBattleText;
  char[] buffer;
  int phase;
  int textSpot;
  char turn = 'n';
  
  Battle(MonsterInstance m)
  {
    enemy = m;
    phase = 1;
    textSpot = 0;
    buffer = "#".toCharArray();
  }
  
  void doBattle()
  {
    if(buffer[0]!='#')
    {
      showBattleText();
    }
    else
    {
      if(phase == 1)
      {
        battleText(enemy.template.battleStartText);
        if(key==' ')
        {
          phase++;
          if(enemy.template.speed>((Player)(ent.get(0))).speed)
          {
            turn = 'e';
          }
          else
          {
            turn = 'p';
          }
        }
      }
      else if(phase == 2);
      {
        if(turn == 'p')
        {
          
        }
      }
     
      showBattleDetails();
    }
  }
  
  void battleText(String s)
  {
    buffer = s.toCharArray();
  }
  
  void showBattleText()
  {
     if(textSpot==-1)
     {
       if(key==' ')
       {
          textSpot = 0;
          buffer = "#".toCharArray();
       }
     }
     else
     {
     fill(0);
     if(curBattleText == null)
     {
       curBattleText = String.valueOf(buffer[0]);
       textSpot++;
     }
     else
     {
       curBattleText = curBattleText + buffer[textSpot];
       textSpot++;
       if(textSpot == buffer.length)
       {
         textSpot = -1;
       }
     }
   }
     
     text(curBattleText,sideBorder,height-(height/3)+topBorder/2);
  }
  
  void showOwnStats()
  {
     float mappedHP = map((((Player)(ent.get(0))).hp),0,(((Player)(ent.get(0))).maxHp),0,width*0.36875);
     float mappedMP = map((((Player)(ent.get(0))).mp),0,(((Player)(ent.get(0))).maxMp),0,width*0.36875);
     
     fill(128);
     rect(sideBorder/2,topBorder/2,width/2.5,height/7);
     
     fill(0);
     text((((Player)(ent.get(0))).name) + " LV " + (((Player)(ent.get(0))).lv),sideBorder/2,topBorder/3);
     
     rect(sideBorder/2+sideBorder/8,topBorder/2+topBorder/8,width*0.36875,height/21);
     fill(0,255,0);
     rect(sideBorder/2+sideBorder/8,topBorder/2+topBorder/8,mappedHP,height/21);
     fill(0);
     rect(sideBorder/2+sideBorder/8,topBorder/2+topBorder/4+height/21,width*0.36875,height/21);
     fill(0,0,255);
     rect(sideBorder/2+sideBorder/8,topBorder/2+topBorder/4+height/21,mappedMP,height/21);
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
  
  void showBattleDetails()
  {
    background(255);
    fill(128);
    rect(sideBorder/2,height-(height/3),width-(sideBorder),height/3-topBorder/2);
    
    showOwnStats();
    showEnemyStats();
    
    text(phase,30,30);
    text(turn,50,30);
    
    showBattleSprite();
  }
  
  void showBattleSprite()
  {
    image(enemy.template.battleSprite,width/2,height/2);
  }

}
