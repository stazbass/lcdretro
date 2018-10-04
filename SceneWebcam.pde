  
import processing.video.*;

class SceneWebcam extends BaseObject {
  Capture cam;
  
  SceneWebcam() {
    String[] cameras = Capture.list();

    if (cameras.length == 0) {
      println("There are no cameras available for capture.");
      exit();
    } else {
      println("Available cameras:");
      for (int i = 0; i < cameras.length; i++) {
        println(i+ " = " + cameras[i]);
      }

      // The camera can be initialized directly using an 
      // element from the array returned by list():
      //cam = getCamera(cameras[13]);
      //cam.start();
    }
  }

  void draw() {
    if(frameCount%2 == 0)
    cam.read();
    cam.loadPixels();
    int[] pixels = cam.pixels;
    int camWidth = cam.width;
    int camHeight = cam.height;
    for(int x = 0; x < camWidth; x++){
      for(int y = 0; y < camHeight; y++){
        color col = color(pixels[y*camWidth + x]);
        render.point(x,y, brightness(col)/255.0, col);
      }
    }
  }

  void update(float dt) {
    super.update(dt);
  }
}
