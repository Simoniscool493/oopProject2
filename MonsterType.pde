class MonsterType
//class of monster templates that instances of monsters are selected from
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
  String onDeath;
  //flavor texts
  char boss;
  color col;
  int lineCol;
  
  MonsterType(String[] details)
  {
    //takes string array of monster details loaded from file
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
    onDeath = details[13];
  
    sprite = loadImage(id+".png");
    
    lineCol = (speed*90)%255-63; //decides monster line color from speed
    
    if(lineCol<63)
    {
      lineCol+=63;
    }

    col = color(red,green,blue);
  }
}

