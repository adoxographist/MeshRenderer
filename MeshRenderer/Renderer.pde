import java.util.LinkedList;

class Renderer
{
  Camera camera;
  color ambientCol;
  LinkedList renderQueue;
  LinkedList lightList;
  
  Renderer(Camera pCamera, color pAmbientCol)
  {
    camera = pCamera;
    
    ambientCol = pAmbientCol;
    renderQueue = new LinkedList();
    lightList = new LinkedList();
  }
  
  public void addToQueue(Mesh pMesh)
  {
    //simple sort
    int i = 0;
    while(true)
    {
      if(this.renderQueue.peekFirst() == null || this.renderQueue.size() <= i)
      {
        this.renderQueue.add(pMesh);
        return;
      }
      if(((Mesh)(this.renderQueue.get(i))).position.z < pMesh.position.z)
      {
        this.renderQueue.add(i, pMesh);
        return;
      }
      i++;
    }
  }
  
  public void addLight(Light pLight)
  {
    lightList.add(pLight);
  }
  
  public void removeLight(Light pLight)
  {
    lightList.remove(pLight);
  }
  
  public void drawMeshes()
  {
    while(this.renderQueue.peekFirst() != null)
    {
      this.drawMesh((Mesh)(renderQueue.remove()));
    }
  }
  
  private void drawMesh(Mesh pMesh)
  {
    pMesh.applyTransformations(camera.rotation, camera.position.neg());
    Vector3 oldScale = new Vector3(0);
    oldScale.copy(pMesh.scale);
    
    if(pMesh.position.z - camera.position.z > 0 && (camera.perspectiveView || pMesh.is2D))
    {
      pMesh.scale(new Vector3(camera.focalLength / (pMesh.position.z - camera.position.z)));
    }
    
    pMesh.calcNormals();
    
    for(int i = 0 ; i < pMesh.triangles.length; i += 0)
    {
      Vector3 point1 = new Vector3(pMesh.publicVertices[pMesh.triangles[i]]);
      float[] uv1 = {pMesh.uvCoords[i*2], pMesh.uvCoords[i*2+1]};
      i++;
      
      Vector3 point2 = new Vector3(pMesh.publicVertices[pMesh.triangles[i]]);
      float[] uv2 = {pMesh.uvCoords[i*2], pMesh.uvCoords[i*2+1]};
      i++;
      
      Vector3 point3 = new Vector3(pMesh.publicVertices[pMesh.triangles[i]]);
      float[] uv3 = {pMesh.uvCoords[i*2], pMesh.uvCoords[i*2+1]};
      i++;
      
      Vector3 p1;
      Vector3 p2;
      Vector3 p3;
      
      if(camera.perspectiveView && !pMesh.is2D)
      {
        p1 = applyPerspective(point1);
        p2 = applyPerspective(point2);
        p3 = applyPerspective(point3);
      }
      else
      {
        p1 = point1;
        p2 = point2;
        p3 = point3;
      }
      
      if(normalTest(pMesh, i/3 - 1) && clampToView(p1, p2, p3))
      {
        if(pMesh.isTextured)
        {
          PImage tTex = pMesh.getTexture(true);
          tint(lambertianShading(pMesh.normals[i/3 - 1], color(255,255,255)));
          int h = tTex.height;
          int w = tTex.width;
          beginShape();
          texture(tTex);
          vertex(p1.x + 0.5 * width, p1.y + 0.5 * height, uv1[0] * w, uv1[1] * h);
          vertex(p2.x + 0.5 * width, p2.y + 0.5 * height, uv2[0] * w, uv2[1] * h);
          vertex(p3.x + 0.5 * width, p3.y + 0.5 * height, uv3[0] * w, uv3[1] * h);
          endShape();
        }
        else
        {
          fill(lambertianShading(pMesh.normals[i/3 - 1], pMesh.objectCol));
          triangle(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y);
        }
      }
    }
    if(pMesh.position.z - camera.position.z > 0)
    {
      pMesh.setScale(oldScale);
    }
  }
  
  private boolean normalTest(Mesh pMesh, int i)
  {
    if(pMesh.normals[i].z > 0)
    {
      return true;
    }
    return false;
  }
  
  private boolean clampToView(Vector3 pPoint1, Vector3 pPoint2, Vector3 pPoint3)
  {
    if(false&&(pPoint1.x >= 0 && pPoint1.x <= width && pPoint1.y >= 0 && pPoint1.y <= height || pPoint2.x >= 0 && pPoint2.x <= width && pPoint2.y >= 0 && pPoint2.y <= height || pPoint3.x >= 0 && pPoint3.x <= width && pPoint3.y >= 0 && pPoint3.y <= height) || (pPoint1.z > 0 || pPoint2.z > 0 || pPoint3.z > 0))
    {
      return true;
    }
    return false;
  }
  
  private Vector3 applyPerspective(Vector3 pPoint)
  {
    float tX = pPoint.x;
    float tY = pPoint.y;
    float tZ = pPoint.z;
    
    tX = tX  / tZ * camera.focalLength;
    tY = tY  / tZ * camera.focalLength;
    
    return new Vector3(tX, tY, tZ);
  }
  
  private color lambertianShading(Vector3 pNormal, color pObjectCol)
  {
    color ret = color(0, 0, 0);
    int s = lightList.size();
    
    for(int i = 0; i < s; i++)
    {
      int a = 0;
      float intensity = (((Light)(lightList.get(i))).getDirection().dotProduct(pNormal));
      ret += color(intensity * (brightness(pObjectCol) + brightness(((Light)(lightList.get(i))).lColor)) + brightness(ambientCol));
    }
    return ret;
  }
}
