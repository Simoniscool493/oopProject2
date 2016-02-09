abstract class MobileEntity extends Entity
{
  float movementSpeed;
  int hp;
  
  float angle1;
  float angle2;

  MobileEntity()
  {
  }
  
  abstract void update();
  
  abstract void move();

}
