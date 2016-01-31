class Room
{
  int background;
  int locX;
  int locY;
  boolean boss;
  boolean shop;
  int roomNumMonsters = 3;
  int numTypeMonsters = 2;
  int[] monstersInRoom;
  
  Room(int x,int y)
  {
    locX = x;
    locY = y;

    if((int)random(10) == 5)
    {
      boss = true;
    }
    else
    {
      monstersInRoom = new int[numTypeMonsters];
      background=(int)random(backgrounds.size());
      chooseMonsters();

    }
    
  }
  
  void makeMonsters()
  {
    if(boss)
    {
      makeMonster(mon.size()-1);
    }
    else
    {
      for(int i=0;i<roomNumMonsters;i++)
      {
        makeMonster(monstersInRoom[(int)random(numTypeMonsters)]);
      }
    }
  }
  
  void chooseMonsters()
  {
    for(int i = 0;i<numTypeMonsters;i++)
    {
      monstersInRoom[i] = (int)random(mon.size()-1);
    }
  }
  
  
}
