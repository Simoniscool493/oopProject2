class Session
{  
  Session(char m)
  {   
    makePlayer();
    loadMonsters();
    loadSprites();
    loadMusic();
    initializeRoom();
    makeDoors();   
    
    mode = m;

    intro.loop();
    
    textBuffer.add("What is your name?\n(Press space to enter name)");
    background(0);
  }

  void makePlayer()
  {
    p = new Player(width/2,height/2);
  }
  
  void loadMonsters()
  {
    String[] monsters = loadStrings("monsters.csv");
    
    for(int i=1;i<monsters.length;i++)
    {
      String[] buffer = split(monsters[i],',');

      MonsterType monster = new MonsterType(buffer);
      mon.add(monster);
    }
  }
  
  void loadSprites()
  {
    title = loadImage("title.png");
    topDoor = loadImage("doors/topDoor.png");
    bottomDoor = loadImage("doors/bottomDoor.png");
    leftDoor = loadImage("doors/leftDoor.png");
    rightDoor = loadImage("doors/rightDoor.png");
    
    loadBackgrounds();
  }
  
  void loadBackgrounds()
  {
    boolean more = true;
    int i = 0;
    
    while(more)
    {
      PImage ba = loadImage("background" + i + ".png");
      if(ba != null)
      {
        backgrounds.add(ba);
        i++;
      }
      else
      {
        more = false;
      }
    }
  }
  
  void loadMusic()
  {
     minimIntro = new Minim(sound_this);
     minimBattle = new Minim(sound_this);
     minimOverworld = new Minim(sound_this);
     minimBoss = new Minim(sound_this);
     minimDeath = new Minim(sound_this);
     
     intro = minimIntro.loadFile("intro.mp3");
     battle = minimBattle.loadFile("battle.mp3");
     overworld = minimOverworld.loadFile("overworld.mp3");
     boss = minimBoss.loadFile("boss.mp3");
     death = minimDeath.loadFile("death.mp3");
  }
  
  void initializeRoom()
  {
    r = new Room(0,0);
    rooms.add(r);
  }
  
  void makeDoors()
  {
    StaticEntity td = new StaticEntity(topDoor,width/2,topBorder/2,'1');
    StaticEntity bd = new StaticEntity(bottomDoor,width/2,height-topBorder/2,'2');
    StaticEntity ld = new StaticEntity(leftDoor,sideBorder/2,height/2,'3');
    StaticEntity rd = new StaticEntity(rightDoor,width-sideBorder/2,height/2,'4');
    ent.add(td);
    ent.add(bd);
    ent.add(ld);
    ent.add(rd);
  }
}
