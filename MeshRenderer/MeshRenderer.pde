color objectcolor = color(0, 100, 0);

Cube c1;
Plane p;
Cube c;
Disk d;
Sprite s;

Light l = new Light(new Vector3(0, 0, 0), color(100, 100, 0));
color ambientCol = color(0, 0, 25);


float fLength = 100;
Camera cam = new Camera(fLength, false);

Renderer render;

void setup()
{
  size(500, 500, P2D);
  PImage tex = loadImage("conc.jpg");
  render = new Renderer(cam, ambientCol);
  render.addLight(l);
  int[] anim = {4,4};
  s = new Sprite(new Vector3(50, 0, 200), 0, new Vector3(100), loadImage("walk.png"), anim, 0.1);
  //s.mesh.alphaCutoff(127);
  p = new Plane(new Vector3(50, 0, 200), new Vector3(0), new Vector3(200), loadImage("tex.png"));
  c = new Cube(new Vector3(0, 100, 150), new Vector3(0), new Vector3(100), tex);
  c1 = new Cube(new Vector3(10, 0, 100), new Vector3(0), new Vector3(100), tex);
  d = new Disk(160, new Vector3(10, 0, 50), new Vector3(0,0,0), new Vector3(100), tex);
  noStroke();
}

void draw()
{
  
  background(ambientCol);
  render.addToQueue(s.mesh);
  /*render.addToQueue(p.mesh);
  render.addToQueue(c1.mesh);
  render.addToQueue(c.mesh);
  render.addToQueue(d.mesh);*/
  render.drawMeshes();
  /*s.mesh.scale = s.mesh.scale.add(new Vector3(1));
  c.mesh.rotate(new Vector3(1,0,-1));
  p.mesh.rotate(new Vector3(0, 0, -1));
  d.mesh.rotate(new Vector3(0,0,1));*/
  //mesh.translate(new Vector3(0,0, 50)); //what?! orthogonal!!
  //c1.mesh.rotate(new Vector3(0, 0, 1));
  //mouseLook(cam);
}

void mouseLook(Camera pCamera)
{
  pCamera.rotation.x = 180 - mouseY / (height / 360f);
  //println(pCamera.rotation.y);
  pCamera.rotation.y = 180 - mouseX / (width / 360f);
  /*if(pCamera.rotation.x < -30)
  {pCamera.rotation.x = -30;}
  if(pCamera.rotation.x > 30)
  {pCamera.rotation.x = 30;}
  if(pCamera.rotation.y < -90)
  {pCamera.rotation.x = -90;}
  if(pCamera.rotation.y > 90)
  {pCamera.rotation.x = 90;}*/
}
