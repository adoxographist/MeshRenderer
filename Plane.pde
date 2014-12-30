class Plane
{
  Mesh mesh;
  
  Plane(Vector3 pPosition, Vector3 pRotation, Vector3 pScale, PImage pTexture)
  {
    Vector3[] verts = {new Vector3(-1, 1, 0),
                       new Vector3(1,  1, 0),
                       new Vector3( 1, -1, 0),
                       new Vector3( -1,  -1, 0)};
    int[] tris = {0, 1, 3,
                  1, 2, 3};
                  
    float[] uv = {0, 1, 1, 1, 0, 0,
                  1, 1, 1, 0, 0, 0};
                 
     this.mesh = new Mesh(verts, tris, pTexture,uv);
     this.mesh.setPosition(pPosition);
     this.mesh.setRotation(pRotation);
     this.mesh.setScale(pScale); 
  }
}
