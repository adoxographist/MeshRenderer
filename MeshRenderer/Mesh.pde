class Mesh
{
  private Vector3[] vertices;
  Vector3[] publicVertices;
  int[] triangles;
  boolean isTextured;
  color objectCol;
  private PImage texture;
  boolean isAnimated;
  int[] animation;
  float animationSpeed;
  float curFrame;
  boolean loop;
  boolean ascending;
  String animationMode;
  float[] uvCoords;
  Vector3 rotation;
  Vector3 position;
  Vector3 scale;
  boolean is2D;
  
  Mesh(Vector3[] pVertices, int[] pTriangles, color pObjectCol)
  {
    this.construct(pVertices, pTriangles);
    
    objectCol = pObjectCol;
    isTextured = false;

    publicVertices = new Vector3[vertices.length];
    
    for(int i = 0; i < vertices.length; i++)
    {
      publicVertices[i] = new Vector3(vertices[i]);
    }
    
    is2D = false;
  }
  
  Mesh(Vector3[] pVertices, int[] pTriangles, PImage pTexture, float[] pUvCoords)
  {
    this.construct(pVertices, pTriangles);
    
    texture = pTexture;
    uvCoords = pUvCoords;
    isTextured = true;
    
    publicVertices = new Vector3[vertices.length];
    
    for(int i = 0; i < vertices.length; i++)
    {
      publicVertices[i] = new Vector3(vertices[i]);
    }
    
    is2D = false;
  }
  
  Mesh(Vector3[] pVertices, int[] pTriangles, PImage pTexture, float[] pUvCoords, int[] pAnimation, float pAnimationSpeed, String pAnimationMode, boolean pLoop)
  {
    this.construct(pVertices, pTriangles);
    
    texture = pTexture;
    uvCoords = pUvCoords;
    isTextured = true;
    
    publicVertices = new Vector3[vertices.length];
    
    for(int i = 0; i < vertices.length; i++)
    {
      publicVertices[i] = new Vector3(vertices[i]);
    }
    
    is2D = false;
    isAnimated = true;
    animation = pAnimation;
    animationSpeed = pAnimationSpeed;
    loop = pLoop;
    animationMode = pAnimationMode;
    if(animationMode == "reverse")
    {
      curFrame = animation[0] * animation[1];
      ascending = false;
    }
    else
    {
      curFrame = 0;
      ascending = true;
    }
  }
  
  Mesh(Vector3[] pVertices, int[] pTriangles, PImage pTexture, float[] pUvCoords, boolean pIs2D)
  {
    this.construct(pVertices, pTriangles);
    
    texture = pTexture;
    uvCoords = pUvCoords;
    isTextured = true;
    
    publicVertices = new Vector3[vertices.length];
    
    for(int i = 0; i < vertices.length; i++)
    {
      publicVertices[i] = new Vector3(vertices[i]);
    }
    
    is2D = pIs2D;
  }
  
  Mesh(Vector3[] pVertices, int[] pTriangles, PImage pTexture, float[] pUvCoords, boolean pIs2D, int[] pAnimation, float pAnimationSpeed, String pAnimationMode, boolean pLoop)
  {
    this.construct(pVertices, pTriangles);
    
    texture = pTexture;
    uvCoords = pUvCoords;
    isTextured = true;
    
    publicVertices = new Vector3[vertices.length];
    
    for(int i = 0; i < vertices.length; i++)
    {
      publicVertices[i] = new Vector3(vertices[i]);
    }
    
    is2D = pIs2D;
    isAnimated = true;
    animation = pAnimation;
    animationSpeed = pAnimationSpeed;
    loop = pLoop;
    animationMode = pAnimationMode;
    if(animationMode == "reverse")
    {
      curFrame = animation[0] * animation[1];
      ascending = false;
    }
    else
    {
      curFrame = 0;
      ascending = true;
    }
  }
  
  private void construct(Vector3[] pVertices, int[] pTriangles)
  {
    vertices = pVertices;
    triangles = pTriangles;
    rotation = new Vector3(0);
    position = new Vector3(0);
    scale = new Vector3(1);
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
  
  public void convertBlackToAlpha(float pThreshold)
  {
    PImage img = createImage(this.texture.width, this.texture.height, ARGB);
    
    for(int i = 0; i < this.texture.pixels.length; i++)
    {
      float r = red(this.texture.pixels[i]);
      float g = green(this.texture.pixels[i]);
      float b = blue(this.texture.pixels[i]);
      float a = (r + b + g) / 3 * pThreshold;
      img.pixels[i] = color(r, g, b, a);
    }
    img.updatePixels();
    this.texture = img;
  }
  
  public void alphaCutoff(float pThreshold)
  {
    PImage img = createImage(this.texture.width, this.texture.height, ARGB);
    
    for(int i = 0; i < this.texture.pixels.length; i++)
    {
      float r = red(this.texture.pixels[i]);
      float g = green(this.texture.pixels[i]);
      float b = blue(this.texture.pixels[i]);
      float a;
      if((r + b + g) / 3 < pThreshold)
      {
        a = 0;
      }
      else
      {
        a = 255;
      }
      img.pixels[i] = color(r, g, b, a);
    }
    img.updatePixels();
    this.texture = img;
  }
  
  public PImage getTexture()
  {
    return this.texture;
  }
  
  public PImage getTexture(boolean animationStep)
  {
    if(!animationStep)
    {
      this.getTexture();
    }
    
    int w = this.texture.width / this.animation[0];
    int h = this.texture.height / this.animation[1];
    int x = (int)abs(this.curFrame) % this.animation[0] * w;
    int y = (int)abs(this.curFrame) / this.animation[1] * h;
    
    PImage img = this.texture.get(x, y, w, h);
    
    if(this.curFrame > this.animation[0] * this.animation[1]-1 && ascending)
    {
      if(animationMode == "pingpong")
      {
        ascending = false;
      }
      else if(animationMode == "normal" && loop)
      {
        this.curFrame -= this.animation[0] * this.animation[1];
      }
    }
    else if(this.curFrame < 0 && !ascending)
    {
      if(animationMode == "pingpong" && loop)
      {
        ascending = true;
      }
      else if(animationMode == "reverse" && loop)
      {
        this.curFrame += this.animation[0] * this.animation[1];
      }
    }
    else
    {
      if(ascending)
      {
        this.curFrame += this.animationSpeed;
      }
      else
      {
        this.curFrame -= this.animationSpeed;
      }
    }
    println(curFrame);
    return img;
  }
}
