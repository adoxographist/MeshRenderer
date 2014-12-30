class Sprite
{
  Mesh mesh;
  
  Sprite(Vector3 pPosition, float pRotation, Vector3 pScale, PImage pTexture)
  {
    Vector3[] verts = {new Vector3(-1, 1, 0),
                       new Vector3(1,  1, 0),
                       new Vector3( 1, -1, 0),
                       new Vector3( -1,  -1, 0)};
    int[] tris = {0, 1, 3,
                  1, 2, 3};
                  
    float[] uv = {0, 1, 1, 1, 0, 0,
                  1, 1, 1, 0, 0, 0};
                 
     this.mesh = new Mesh(verts, tris, pTexture, uv);
     this.mesh.setPosition(pPosition);
     this.mesh.setRotation(new Vector3(0, 0, pRotation));
     this.mesh.setScale(pScale); 
  }
  Sprite(Vector3 pPosition, float pRotation, Vector3 pScale, PImage pTexture, int[] pAnimation, float pAnimationSpeed, String pAnimationMode, boolean pLoop)
  {
    Vector3[] verts = {new Vector3(-1, 1, 0),
                       new Vector3(1,  1, 0),
                       new Vector3( 1, -1, 0),
                       new Vector3( -1,  -1, 0)};
    int[] tris = {0, 1, 3,
                  1, 2, 3};
                  
    float[] uv = {0, 1, 1, 1, 0, 0,
                  1, 1, 1, 0, 0, 0};
                 
     this.mesh = new Mesh(verts, tris, pTexture, uv, true, pAnimation, pAnimationSpeed, pAnimationMode, pLoop);
     this.mesh.setPosition(pPosition);
     this.mesh.setRotation(new Vector3(0, 0, pRotation));
     this.mesh.setScale(pScale); 
  }
}
