class Cube
{
  Mesh mesh;
  
  Cube(Vector3 pPosition, Vector3 pRotation, Vector3 pScale, PImage pTexture)
  {
    Vector3[] verts = {new Vector3(-1, -1, -1),
                       new Vector3( 1, -1, -1),
                       new Vector3(-1,  1, -1),
                       new Vector3( 1,  1, -1),
                       new Vector3(-1, -1,  1),
                       new Vector3( 1, -1,  1),
                       new Vector3(-1,  1,  1),
                       new Vector3( 1,  1,  1)};
                       
    int[] tris = {2, 1, 0,
                  1, 2, 3,
                  4, 5, 6,
                  7, 6, 5,
                  1, 3, 7,
                  7, 5, 1,
                  6, 2, 0,
                  0, 4, 6,
                  0, 1, 5,
                  5, 4, 0,
                  2, 6, 7,
                  7, 3, 2};
                  
    float[] uv = {  1, 1, 0, 0, 1, 0,
                    1, 1, 0, 0, 0, 1,
                    0, 1, 0, 0, 1, 1,
                    1, 0, 0, 0, 1, 1,
                    0, 1, 0, 0, 1, 0,
                    0, 1, 1, 1, 1, 0,
                    0, 1, 0, 0, 1, 0,
                    0, 1, 1, 1, 1, 0,
                    0, 1, 0, 0, 1, 0,
                    0, 1, 1, 1, 1, 0,
                    0, 1, 0, 0, 1, 0,
                    0, 1, 1, 1, 1, 0};
                    
     this.mesh = new Mesh(verts, tris, pTexture, uv);
     this.mesh.setPosition(pPosition);
     this.mesh.setRotation(pRotation);
     this.mesh.setScale(pScale); 
  }
  
  Cube(Vector3 pPosition, Vector3 pRotation, Vector3 pScale, PImage pTexture, int[] pAnimation, float pAnimationSpeed, String pAnimationMode, boolean pLoop)
  {
    Vector3[] verts = {new Vector3(-1, -1, -1),
                       new Vector3( 1, -1, -1),
                       new Vector3(-1,  1, -1),
                       new Vector3( 1,  1, -1),
                       new Vector3(-1, -1,  1),
                       new Vector3( 1, -1,  1),
                       new Vector3(-1,  1,  1),
                       new Vector3( 1,  1,  1)};
                       
    int[] tris = {2, 1, 0,
                  1, 2, 3,
                  4, 5, 6,
                  7, 6, 5,
                  1, 3, 7,
                  7, 5, 1,
                  6, 2, 0,
                  0, 4, 6,
                  0, 1, 5,
                  5, 4, 0,
                  2, 6, 7,
                  7, 3, 2};
                  
    float[] uv = {  1, 1, 0, 0, 1, 0,
                    1, 1, 0, 0, 0, 1,
                    0, 1, 0, 0, 1, 1,
                    1, 0, 0, 0, 1, 1,
                    0, 1, 0, 0, 1, 0,
                    0, 1, 1, 1, 1, 0,
                    0, 1, 0, 0, 1, 0,
                    0, 1, 1, 1, 1, 0,
                    0, 1, 0, 0, 1, 0,
                    0, 1, 1, 1, 1, 0,
                    0, 1, 0, 0, 1, 0,
                    0, 1, 1, 1, 1, 0};
                    
     this.mesh = new Mesh(verts, tris, pTexture, uv, pAnimation, pAnimationSpeed, pAnimationMode, pLoop);
     this.mesh.setPosition(pPosition);
     this.mesh.setRotation(pRotation);
     this.mesh.setScale(pScale); 
  }
}
