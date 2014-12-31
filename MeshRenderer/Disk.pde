class Disk
{
  Mesh mesh;
  
  Disk(int pResolution, Vector3 pPosition, Vector3 pRotation, Vector3 pScale, PImage pTexture)
  {
    Vector3[] verts = new Vector3[pResolution + 1];
    verts[0] = new Vector3(0, 0, 0);
    
    float angle = TWO_PI / 360f * (360f/(pResolution-1));
    
    for(int i = 0; i < pResolution; i++)
    {
      float c = cos(angle * i);
      float s = sin(angle * i);
      
      verts[i + 1] = new Vector3(- s, c, 0);
    }
    
    int[] tris = new int[pResolution * 3];
    
    for(int i = 0; i < tris.length; i+=3)
    {
      tris[i] = 0;
      tris[i + 1] = i/3 + 1;
      
      if(i/3 + 2 < verts.length)
      {
        tris[i + 2] = i/3 + 2;
      }
      else
      {
        tris[i + 2] = 1;
      }
    }
                  
    float[] uv = new float[tris.length * 2];
    for(int i = 0; i < uv.length; i+=2)
    {
      uv[i]     = verts[tris[i/2]].x / 2 + 0.5;
      uv[i + 1] = verts[tris[i/2]].y / 2 + 0.5;
    }
    
    this.mesh = new Mesh(verts, tris, pTexture, uv);
    this.mesh.setPosition(pPosition);
    this.mesh.setRotation(pRotation);
    this.mesh.setScale(pScale);
  }
  
  Disk(int pResolution, Vector3 pPosition, Vector3 pRotation, Vector3 pScale, PImage pTexture, int[] pAnimation, float pAnimationSpeed, String pAnimationMode, boolean pLoop)
  {
    Vector3[] verts = new Vector3[pResolution + 1];
    verts[0] = new Vector3(0, 0, 0);
    
    float angle = TWO_PI / 360f * (360f/(pResolution-1));
    
    for(int i = 0; i < pResolution; i++)
    {
      float c = cos(angle * i);
      float s = sin(angle * i);
      
      verts[i + 1] = new Vector3(- s, c, 0);
    }
    
    int[] tris = new int[pResolution * 3];
    
    for(int i = 0; i < tris.length; i+=3)
    {
      tris[i] = 0;
      tris[i + 1] = i/3 + 1;
      
      if(i/3 + 2 < verts.length)
      {
        tris[i + 2] = i/3 + 2;
      }
      else
      {
        tris[i + 2] = 1;
      }
    }
                  
    float[] uv = new float[tris.length * 2];
    for(int i = 0; i < uv.length; i+=2)
    {
      uv[i]     = verts[tris[i/2]].x / 2 + 0.5;
      uv[i + 1] = verts[tris[i/2]].y / 2 + 0.5;
    }
    
    this.mesh = new Mesh(verts, tris, pTexture, uv, pAnimation, pAnimationSpeed, pAnimationMode, pLoop);
    this.mesh.setPosition(pPosition);
    this.mesh.setRotation(pRotation);
    this.mesh.setScale(pScale);
  }
}
