class Mesh
{
  private Vector3[] vertices;
  Vector3[] publicVertices;
  int[] triangles;
  boolean isTextured;
  color objectCol;
  private Texture texture;
  float[] uvCoords;
  Vector3 rotation;
  Vector3 position;
  Vector3 scale;
  boolean is2D;
  
  Mesh(Vector3[] pVertices, int[] pTriangles, color pObjectCol)
  {
    this.construct(pVertices, pTriangles);
    
    isTextured = false;
    objectCol = pObjectCol;
    is2D = false;
  }
  
  Mesh(Vector3[] pVertices, int[] pTriangles, PImage pImage, float[] pUvCoords)
  {
    this.construct(pVertices, pTriangles);
    
    isTextured = true;
    texture = new Texture(pImage);
    uvCoords = pUvCoords;
    is2D = false;
  }
  
  Mesh(Vector3[] pVertices, int[] pTriangles, Texture pTexture, float[] pUvCoords)
  {
    this.construct(pVertices, pTriangles);
    
    isTextured = true;
    texture = pTexture;
    uvCoords = pUvCoords;
    is2D = false;
  }
  
  Mesh(Vector3[] pVertices, int[] pTriangles, PImage pImage, float[] pUvCoords, int[] pAnimation, float pAnimationSpeed, String pAnimationMode, boolean pLoop)
  {
    
    this.construct(pVertices, pTriangles);
    
    texture = new Texture(pImage, pAnimation, pAnimationSpeed, pAnimationMode, pLoop);
    uvCoords = pUvCoords;
    isTextured = true;
    is2D = false;
  }
  
  Mesh(Vector3[] pVertices, int[] pTriangles, PImage pImage, float[] pUvCoords, boolean pIs2D)
  {
    this.construct(pVertices, pTriangles);
    
    isTextured = true;
    texture = new Texture(pImage);
    uvCoords = pUvCoords;
    is2D = pIs2D;
  }
  
  Mesh(Vector3[] pVertices, int[] pTriangles, Texture pTexture, float[] pUvCoords, boolean pIs2D)
  {
    this.construct(pVertices, pTriangles);
    
    isTextured = true;
    texture = pTexture;
    uvCoords = pUvCoords;
    is2D = pIs2D;
  }
  
  Mesh(Vector3[] pVertices, int[] pTriangles, PImage pImage, float[] pUvCoords, boolean pIs2D, int[] pAnimation, float pAnimationSpeed, String pAnimationMode, boolean pLoop)
  {
    this.construct(pVertices, pTriangles);
    
    isTextured = true;
    texture = new Texture(pImage, pAnimation, pAnimationSpeed, pAnimationMode, pLoop);
    uvCoords = pUvCoords;
    is2D = pIs2D;
  }
  
  private void construct(Vector3[] pVertices, int[] pTriangles)
  {
    vertices = pVertices;
    triangles = pTriangles;
    rotation = new Vector3(0);
    position = new Vector3(0);
    scale = new Vector3(1);
    
    publicVertices = new Vector3[vertices.length];
    
    for(int i = 0; i < vertices.length; i++)
    {
      publicVertices[i] = new Vector3(vertices[i]);
    }
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
  
  void scale(Vector3 pScale)
  {
    scale = scale.multiply(pScale);
  }
  
  void setScale(Vector3 pScale)
  {
    scale.copy(pScale);
  }
  
  void applyTransformations(Vector3 pRotation, Vector3 pPosition)
  {
      float s;
      float c;
      float x;
      float y;
      float z;
      Vector3 pPivot = new Vector3(this.position);
      /*for(int i = 0; i < vertices.length; i++)
      {
        pPivot = pPivot.add(vertices[i]);
      }
      
      pPivot = pPivot.dotProduct(1f / (float)(vertices.length));*/
      
      for(int i = 0; i < vertices.length; i++)
      {
        publicVertices[i].copy(vertices[i]);
        
        //pivot to origin
        publicVertices[i].x -= pPivot.x;
        publicVertices[i].y -= pPivot.y;
        publicVertices[i].z -= pPivot.z;
        
        //translation
        publicVertices[i].x += position.x;
        publicVertices[i].y += position.y;
        publicVertices[i].z += position.z;
        
        //rotation
        if(!is2D)
        {
          //x
          c = cos(2*PI/360f*rotation.x);
          s = sin(2*PI/360f*rotation.x);
          
          y = publicVertices[i].y;
          z = publicVertices[i].z;
          
          publicVertices[i].y = y * c - z * s;
          publicVertices[i].z = z * c + y * s;
          
          //y
          c = cos(2*PI/360f*rotation.y);
          s = sin(2*PI/360f*rotation.y);
          
          x = publicVertices[i].x;
          z = publicVertices[i].z;
          
          publicVertices[i].x = x * c - z * s;
          publicVertices[i].z = z * c + x * s;
        }
        //z
        c = cos(2*PI/360f*rotation.z);
        s = sin(2*PI/360f*rotation.z);
        
        x = publicVertices[i].x;
        y = publicVertices[i].y;
        
        publicVertices[i].x = x * c - y * s;
        publicVertices[i].y = y * c + x * s;
        
        //scale
        publicVertices[i].x *= scale.x;
        publicVertices[i].y *= scale.y;
        publicVertices[i].z *= scale.z;
        
        //back to old pos
        publicVertices[i].x += pPivot.x;
        publicVertices[i].y += pPivot.y;
        publicVertices[i].z += pPivot.z;
        
        //camera movement
        publicVertices[i].x -= width / 2;
        publicVertices[i].y -= height / 2;
        
        //rotation
        if(!is2D)
        {
          //x
          c = cos(2*PI/360f*pRotation.x);
          s = sin(2*PI/360f*pRotation.x);
          
          y = publicVertices[i].y;
          z = publicVertices[i].z;
          
          publicVertices[i].y = y * c - z * s;
          publicVertices[i].z = z * c + y * s;
          
          //y
          c = cos(2*PI/360f*pRotation.y);
          s = sin(2*PI/360f*pRotation.y);
          
          x = publicVertices[i].x;
          z = publicVertices[i].z;
          
          publicVertices[i].x = x * c - z * s;
          publicVertices[i].z = z * c + x * s;
        }
        
        //z
        c = cos(2*PI/360f*pRotation.z);
        s = sin(2*PI/360f*pRotation.z);
        
        x = publicVertices[i].x;
        y = publicVertices[i].y;
        
        publicVertices[i].x = x * c - y * s;
        publicVertices[i].y = y * c + x * s;
        
       //translation
        publicVertices[i].x += pPosition.x;
        publicVertices[i].y += pPosition.y;
        publicVertices[i].z += pPosition.z;
        
        publicVertices[i].x += width / 2;
        publicVertices[i].y += height / 2;
      }
  }
  
  public PImage getTexture()
  {
    return this.texture.getImage();
  }
  
  public PImage getTexture(boolean animationStep)
  {
     return this.texture.getImage(animationStep);
  }
}
