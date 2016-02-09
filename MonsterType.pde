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
  
    sprite = loadImage(id+".png");
    
    int[] cols = new int[4];
    
//    int red = (atk*50)%255;
//    int green = (def*40)%255;
//    int blue = (hp*70)%255;
//    lineCol =(speed*90)%255;
    cols[0] = (atk*25)%170+80;
    cols[1] = (def*53)%170+80;
    cols[2] = (hp*98)%170+80;
    cols[3] = (speed*90)%255-63;
    
    for(int i=0;i<3;i++)
    {
      if(cols[i]<63)
      {
        cols[i]+=63;
      }
    }

    col = color(cols[0],cols[1],cols[2]);
    lineCol = cols[3];
    println(cols[0],cols[1],cols[2],cols[3]);
  }
  

}

