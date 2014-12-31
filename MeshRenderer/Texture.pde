class Texture
{
  private PImage image;
  boolean isAnimated;
  int[] animation;
  float animationSpeed;
  float curFrame;
  boolean loop;
  boolean ascending;
  String animationMode;
  
  Texture(PImage pImage, int[] pAnimation, float pAnimationSpeed, String pAnimationMode, boolean pLoop)
  {
    image = pImage;
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
  
  Texture(PImage pImage)
  {
    image = pImage;
    isAnimated = false;
  }
  
   public void convertBlackToAlpha(float pThreshold)
  {
    PImage img = createImage(this.image.width, this.image.height, ARGB);
    
    for(int i = 0; i < this.image.pixels.length; i++)
    {
      float r = red(this.image.pixels[i]);
      float g = green(this.image.pixels[i]);
      float b = blue(this.image.pixels[i]);
      float a = (r + b + g) / 3 * pThreshold;
      img.pixels[i] = color(r, g, b, a);
    }
    img.updatePixels();
    this.image = img;
  }
  
  public void alphaCutoff(float pThreshold)
  {
    PImage img = createImage(this.image.width, this.image.height, ARGB);
    
    for(int i = 0; i < this.image.pixels.length; i++)
    {
      float r = red(this.image.pixels[i]);
      float g = green(this.image.pixels[i]);
      float b = blue(this.image.pixels[i]);
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
    this.image = img;
  }
  
  public PImage getImage()
  {
    return this.image;
  }
  
  public PImage getImage(boolean animationStep)
  {
    if(!animationStep || !isAnimated)
    {
      this.getImage();
    }
    
    int w = this.image.width / this.animation[0];
    int h = this.image.height / this.animation[1];
    int x = (int)abs(this.curFrame) % this.animation[0] * w;
    int y = (int)abs(this.curFrame) / this.animation[1] * h;
    
    PImage img = this.image.get(x, y, w, h);
    
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
    return img;
  }
}
