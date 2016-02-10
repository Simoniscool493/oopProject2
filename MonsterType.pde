class MonsterType
{
  int id;
  String name;
  int hp;
  int atk;
  int def;
  int speed;
  int exp;
  PImage sprite;
  String battleStartText;
  String specialAttack;
  char boss;
  color col;
  int lineCol;
  
  MonsterType(String[] details)
  {
    id = parseInt(details[0]);
    name = details[1];
    hp = parseInt(details[2]);
    atk = parseInt(details[3]);
    def = parseInt(details[4]);
    speed = parseInt(details[5]);
    battleStartText = details[6];
    exp = parseInt(details[7]);
    boss = (details[8]).charAt(0);
    specialAttack = details[9];
    int red = parseInt(details[10]);
    int green = parseInt(details[11]);
    int blue = parseInt(details[12]);
  
    sprite = loadImage(id+".png");
    
    lineCol = (speed*90)%255-63;
    
    if(lineCol<63)
    {
      lineCol+=63;
    }

    col = color(red,green,blue);
  }
}

