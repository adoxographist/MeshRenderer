class Vector3
{
  float x;
  float y;
  float z;
  
  public Vector3(int pX, int pY, int pZ)
  {
    x = (float)pX;
    y = (float)pY;
    z = (float)pZ;
  }
  public Vector3(float pX, float pY, float pZ)
  {
    x = pX;
    y = pY;
    z = pZ;
  }
  public Vector3(Vector3 pVector3)
  {
    x = pVector3.x;
    y = pVector3.y;
    z = pVector3.z;
  }
  
  public Vector3(float pValue)
  {
    x = pValue;
    y = pValue;
    z = pValue;
  }
  
  public Vector3 crossProduct(Vector3 pVector3)
  {
    return new Vector3((this.y * pVector3.z) - (this.z * pVector3.y), (this.z * pVector3.x) - (this.x * pVector3.z), (this.x * pVector3.y) - (this.y * pVector3.x));
  }
  
  public float dotProduct(Vector3 pVector3)
  {
    return this.x * pVector3.x + this.y * pVector3.y + this.z * pVector3.z;
  }
  
  public Vector3 dotProduct(float pScalar)
  {
    return new Vector3(this.x * pScalar, this.y * pScalar, this.z * pScalar);
  }
  
  public Vector3 add(Vector3 pVector3)
  {
    return new Vector3(this.x + pVector3.x, this.y + pVector3.y, this.z + pVector3.z); 
  }
  
  public void copy(Vector3 pVector3)
  {
    this.x = pVector3.x;
    this.y = pVector3.y;
    this.z = pVector3.z;
  }
  
  public Vector3 multiply(Vector3 pVector3)
  {
    return new Vector3(this.x * pVector3.x, this.y * pVector3.y, this.z * pVector3.z);
  }
   
  public Vector3 neg()
  {
    return this.dotProduct(-1);
  }
  
  public Vector3 angleToVector()
  {
        Vector3 newVec = new Vector3(0, 0, 1);
        float x;
        float y;
        float z;
        float c;
        float s;
        //x
        c = cos(2*PI/360f*this.x);
        s = sin(2*PI/360f*this.x);
        
        y = newVec.y;
        z = newVec.z;
        
        newVec.y = y * c - z * s;
        newVec.z = z * c + y * s;
        
        //y
        c = cos(2*PI/360f*this.y);
        s = sin(2*PI/360f*this.y);
        
        x = newVec.x;
        z = newVec.z;
        
        newVec.x = x * c - z * s;
        newVec.z = z * c + x * s;
        
        //z
        c = cos(2*PI/360f*this.z);
        s = sin(2*PI/360f*this.z);
        
        x = newVec.x;
        y = newVec.y;
        
        newVec.x = x * c - y * s;
        newVec.y = y * c + x * s;
        
        //this.copy(newVec);
        return newVec;
  }
  
  public float magnitude()
  {
    return sqrt(this.x * this.x + this.y * this.y + this.z * this.z);
  }
  
  public void normalize()
  {
    float mag = this.magnitude();
    
    this.x /= mag;
    this.y /= mag;
    this.z /= mag;
  }

  public String toString()
  {
    return this.x + ", " + this.y + ", " + this.z;
  }
}
