class Camera
{
  float focalLength;
  Vector3 position;
  Vector3 rotation;
  boolean perspectiveView;
  Camera(float pFocalLength, boolean pPerspectiveView)
  {
    focalLength = pFocalLength;
    position = new Vector3(0);
    rotation = new Vector3(0);
    perspectiveView = pPerspectiveView;
  }
  
  Camera(float pFocalLength, Vector3 pPosition, Vector3 pRotation, boolean pPerspectiveView)
  {
    focalLength = pFocalLength;
    position = pPosition;
    rotation = pRotation;
    perspectiveView = pPerspectiveView;
  }
  
  void rotate(Vector3 pAngle)
  {
    rotation = rotation.add(pAngle);
  }
  
  void setRotation(Vector3 pAngle)
  {
    rotation.copy(pAngle);
  }
  
  void translate(Vector3 pPosition)
  {
    position = position.add(pPosition);
  }
  
  void setPosition(Vector3 pPosition)
  {
    position.copy(pPosition);
  }
}
