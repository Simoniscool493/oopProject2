abstract class MobileEntity extends Entity
{
  float movementSpeed;

  MobileEntity()
  {
  }
  
  abstract void update();
  
  abstract void move();

}
