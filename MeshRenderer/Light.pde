class Light
{
  Vector3 rotation;
  color lColor;
  
  Light(Vector3 pRotation, color pLColor)
  {
    rotation = pRotation;
    lColor = pLColor;
  }
  
  void rotate(Vector3 pRotation)
  {
    this.rotation.add(pRotation);
  }
  
  void setRotation(Vector3 pRotation)
  {
    this.rotation.copy(pRotation);
  }
  
  Vector3 getDirection()
  {
    return this.rotation.angleToVector();
  }
}
