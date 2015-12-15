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
  
  MonsterType()
  {
  }
  
  void printDetails()
  {
    println(id,name,hp,atk,def,speed);
  }
}

