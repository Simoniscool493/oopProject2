class MonsterType
{
  int id;
  String name;
  int hp;
  int atk;
  int def;
  int speed;
  PImage overworldSprite;
  PImage battleSprite;
  String battleStartText;
  
  MonsterType()
  {
  }
  
  void printDetails()
  {
    println(id,name,hp,atk,def,speed);
  }
}

