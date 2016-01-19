class Room
{
  PImage background;
  int locX;
  int locY;
  boolean boss;
  boolean shop;
  int roomNumMonsters = 3;
  
  Room(int x,int y)
  {
    locX = x;
    locY = y;
    
  }
  
  void makeMonsters()
  {
    for(int i=0;i<roomNumMonsters;i++)
    {
      //makeMonster((int)random(mon.size()));
    }
    
  }
}
