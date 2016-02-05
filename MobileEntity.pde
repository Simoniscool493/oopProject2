abstract class MobileEntity extends Entity
{
  float movementSpeed;
  int hp;

  MobileEntity()
  {
  }
  
  abstract void update();
  
  abstract void move();

}
