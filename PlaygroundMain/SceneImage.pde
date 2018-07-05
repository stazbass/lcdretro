class SceneImage extends BaseObject{
  PImage image;
  SceneImage(){
    image = loadImage("poisonclan.png");
    image.loadPixels();
  }
  
  public void draw(GridRenderer r){
    int[] pixels = image.pixels;
    for(int x = 0; x < image.width; x++){
      for(int y = 0; y < image.height; y++){
        r.point(x,y,brightness(color(pixels[y*image.width + x])));
      }
    }
  }
}
