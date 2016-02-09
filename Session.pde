class Session
{  
  Session()
  {   
    makePlayer();
    loadMonsters();
    loadSprites();
    loadMusic();
    initializeRoom();
    makeDoors();    
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
      MonsterType monster = new MonsterType();
      mon.add(monster);
      
      String[] buffer = split(monsters[i],',');
      
      monster.id = parseInt(buffer[0]);
      monster.name = buffer[1];
      monster.hp = parseInt(buffer[2]);
      monster.atk = parseInt(buffer[3]);
      monster.def = parseInt(buffer[4]);
      monster.speed = parseInt(buffer[5]);
      monster.battleStartText = buffer[6];
      monster.exp = parseInt(buffer[7]);
      monster.boss = (buffer[8]).charAt(0);
  
      monster.sprite = loadImage(monster.id+".png");
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
