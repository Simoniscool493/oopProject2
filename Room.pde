class Room
//class that stores data about rooms in the dungeon
{
  int background;
  int locX;
  int locY;
  boolean boss;
  boolean shop;
  int roomNumMonsters = (int)random(5)+1;
  int numTypeMonsters = (int)random(4)+1;
  int[] monstersInRoom;
  color col;
  
  Room(int x,int y)
  {
    locX = x;
    locY = y;

    if(((int)random(10) == 5) && abs(locX)+ abs(locY) > 6) //if far enough from center, has a chance of spawning the Boss
    {
      boss = true;
    }
    else
    {
      monstersInRoom = new int[numTypeMonsters];
      chooseMonsters();
    }
    
    //background=(int)random(backgrounds.size());
    col = color(64+(int)random(191),64+(int)random(191),64+(int)random(191));
    //randomly chooses a background color
  }
  
  void makeMonsters() //makes monsters in the room
  {
    if(boss)
    {
      makeMonster(mon.size()-1);
    }
    else
    {
      roomNumMonsters = (int)random(5)+1;
      for(int i=0;i<roomNumMonsters;i++)
      {
        makeMonster(monstersInRoom[(int)random(numTypeMonsters)]);
      }
    }
  }
  
  void chooseMonsters() //chooses which types of monster this room will spawn
  {
    for(int i = 0;i<numTypeMonsters;i++)
    {
      monstersInRoom[i] = (int)random(mon.size()-1);
    }
  }
  
  void makeMonster(int id) //makes a monster of the given id
  {
    Entity monster = new MonsterInstance(mon.get(id));
    if(((MonsterInstance)(monster)).template.boss == 'y') //puts monster in center if it's the Boss
    {
      monster.pos.x = width/2;
      monster.pos.y = height/2;
    }
    ent.add(monster);
  }
  
  void clearMonsters() //clears all monsters from the room
  {
    int size = ent.size();
    int i = 0;
   
    while(i<ent.size())
    {
      if(ent.get(i) instanceof MonsterInstance)
      {
        ent.remove(i);
      }
      else
      {
        i++;
      }
    } 
  }
  
  void changeRoom(char c)
  {
    if(c == '1')
    {
      tryRoom(0,-1);
    }
    else if(c == '2')
    {
      tryRoom(0,1);
    }
    else if(c == '3')
    {
      tryRoom(-1,0);
    }
    else if(c == '4')
    {
      tryRoom(1,0);
    }
  }

  void tryRoom(int x,int y) //checks if room being entered is new, and creates it if it is
  {
    boolean used = false;
    for(Room rm:rooms)
    {
      if(rm.locX == r.locX+x && rm.locY == r.locY+y && !used)
      {
        r = rm;
        used = true;
      }      
    }
    
    if(!used)
    {
      Room room = new Room(r.locX+x,r.locY+y);
      rooms.add(room);
      r = room;
      
      if(p.mp<p.maxMp)
      {
        p.mp++;
      }
    }
    
    relocatePlayer(x,y); 
  }

  void relocatePlayer(int x,int y) //puts player beside the door in the new room
  {
    if(x == 1)
    {
      p.pos.x = sideBorder*1.2;
      p.pos.y = height/2;
    }
    else if(x == -1)
    {
      p.pos.x = width-sideBorder*1.2;
      p.pos.y = height/2;
    }
    else if(y == 1)
    {
      p.pos.x = width/2;
      p.pos.y = topBorder*1.2;
    }
    else if(y == -1)
    {
      p.pos.x = width/2;
      p.pos.y = height-topBorder*1.2;
    }
  }
}
