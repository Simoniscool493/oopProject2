abstract class MobileEntity extends Entity
//abstract class for all entities that move
{
  float movementSpeed;
  int hp;
  
  float angle1;
  float angle2;
  //angles for animating the entity's overworld sprite

  MobileEntity()
  {
  }
  
  abstract void update();
  
  abstract void move();

}
