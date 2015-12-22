class Battle
{
  MonsterInstance enemy;
  String curBattleText;
  int phase;
  char turn = 'n';
  
  Battle(MonsterInstance m)
  {
    enemy = m;
    phase = 1;
  }
  
  void doBattle()
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
  
  void battleText(String s)
  {
    curBattleText = s;
  }
  
  void showBattleText()
  {
     fill(0);
     text(curBattleText,sideBorder,height-(height/3)+topBorder/2);
  }
  
  void showBattleDetails()
  {
    background(255);
    fill(128);
    rect(sideBorder/2,height-(height/3),width-(sideBorder),height/3-topBorder/2);
    rect(sideBorder/2,topBorder/2,width/2.5,height/7);
    rect(width-sideBorder/2-width/2.5,topBorder/2,width/2.5,height/7);

    
    text(phase,30,30);
    text(turn,50,30);
    
    showBattleText();
    showBattleSprite();
  }
  
  void showBattleSprite()
  {
    image(enemy.template.battleSprite,width/2,height/2);
  }

}
