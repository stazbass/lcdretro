  
import processing.video.*;

class SceneWebcam extends BaseObject {
  Capture cam;
  int camWidth;
  int camHeight;
  SceneWebcam(PApplet p) {
    String[] cameras = Capture.list();

    if (cameras.length == 0) {
      println("There are no cameras available for capture.");
      exit();
    } else {
      println("Available cameras:");
      for (int i = 0; i < cameras.length; i++) {
        println(i+ " = " + cameras[i]);
      }
      cam = new Capture(p, cameras[0]);
      cam.start();
      camHeight = cam.height;
      camWidth = cam.width;
      println("Cam w, h: " + camWidth + " , " + camHeight);
      

    }
  }

  void draw() {
    //if(frameCount%2 == 0)
    if(cam.available() == true){ //<>//
        cam.read();
    }
        println("****************");
    image(cam, 0, 0);
    cam.loadPixels();
    int[] pixels = new int [cam.pixels.length];
    arrayCopy(cam.pixels, pixels, pixels  .length);
    for(int x = 0; x < camWidth; x++){
      for(int y = 0; y < camHeight; y++){
        int pix = pixels[y*camWidth+x];
        color col = color(red(pix), green(pix), blue(pix));
        render.point(x,y, brightness(col), col);
        //println(col);
      }
    }

  }

  void update(float dt) {
    super.update(dt);
  }
}
