class Session
//class containing the current session. only one at a time
{  
  Session(char m) //constructor that initializes the session, loads all data, and plays the game intro
  {   
    makePlayer();
    loadMonsters();
    loadSprites();
    loadMusic();
    initializeRoom();
    makeDoors();   
    
    mode = m;

    intro.loop();
    
    background(0);
  }

  void makePlayer() //creates the player character
  {
    p = new Player(width/2,height/2);
  }
  
  void loadMonsters() //loads all monster types from monsters.csv
  {
    String[] monsters = loadStrings("monsters.csv");
    
    for(int i=1;i<monsters.length;i++)
    {
      String[] buffer = split(monsters[i],',');

      MonsterType monster = new MonsterType(buffer);
      mon.add(monster);
    }
  }
  
  void loadSprites() //loads all sprites for the game
  {
    title = loadImage("title.png");
    topDoor = loadImage("doors/topDoor.png");
    bottomDoor = loadImage("doors/bottomDoor.png");
    leftDoor = loadImage("doors/leftDoor.png");
    rightDoor = loadImage("doors/rightDoor.png");
    caveWall = loadImage("cavewall.png");
  }
    
  void loadMusic() //loads all music files
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
  
  void initializeRoom() //initializes the first room
  {
    r = new Room(0,0);
    rooms.add(r);
  }
  
  void makeDoors() //makes and adds the doors
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
