class Room
{
  ArrayList<MonsterInstance> monsters;
  PImage background;
  int locX;
  int locY;
  boolean boss;
  boolean shop;
  
  Room(int x,int y)
  {
    locX = x;
    locY = y;
    monsters = new ArrayList<MonsterInstance>();
  }
}
