class Battle
{
  MonsterInstance enemy;
  String curBattleText;
  
  Battle(MonsterInstance m)
  {
    enemy = m;
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

}
