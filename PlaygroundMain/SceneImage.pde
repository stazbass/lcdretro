class SceneImage extends BaseObject{
  PImage image;
  SceneImage(){
    image = loadImage("fractal.jpg");
    image.loadPixels();
    image.resize(grid.width,grid.height);
  }
  
  public void draw(){
    int[] pixels = image.pixels;
    for(int x = 0; x < grid.width; x++){
      for(int y = 0; y < grid.height; y++){
        int pixelIndex = y * image.width + x;
        render.point(x,y,1, color(pixels[pixelIndex]));
      }
    }
  }
}