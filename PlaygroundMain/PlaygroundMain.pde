import com.hamoid.*;
import shiffman.box2d.*;


final int SCREEN_WIDTH = 1500;
final int SCREEN_HEIGHT = 1000;

VideoRecorder videoRecorder;
Grid grid;
GridRenderer render;
Scenes scenes;
PImage image;


// ------------
void setup() {
  fullScreen(P3D);
  //size(1900, 768, P3D);
  background(0);
  stroke(220, 150, 220);
  fill(250, 10, 250);
  rectMode(CENTER);
  frameRate(100);
  strokeWeight(Config.BORDER_WIDTH);

  videoRecorder = new VideoRecorder(Config.RECORD_VIDEO, new VideoExport(this, "interactive.mp4"));
  videoRecorder.start();
  grid = new Grid(width/Config.CELL_SIZE, height/Config.CELL_SIZE, Config.CELL_SIZE, Config.CELL_SIZE, Config.CELL_SIZE/2, Config.CELL_SIZE/2);
  render = new GridRenderer(grid);
  scenes = new Scenes(render);
  image = loadImage("poisonclan.png");
}

void draw() {
  float delta = mouseX != 0 ? 1.0/mouseX : 1.0;

  clear();
  drawAll(render);
  updateAll(1/50.0);//delta);
}

void drawAll(GridRenderer render) {
  scenes.draw(render);
  image.loadPixels();
  int[] pixels = image.pixels;
  if(pixels.length > 0)
  for(int i = 0; i < 320; i++){
    for(int j = 0; j < 240; j++){
      //print(color().
      render.point(i,j,brightness(pixels[j*image.width + i])/255.0);
    }
  }
  image.updatePixels();
  println(pixels.length);

  grid.draw();
}

void updateAll(float delta) {
  scenes.update(delta);
  grid.update(delta);
  videoRecorder.frame();
}

void keyPressed() {
  if (key == 'q') {
    exit();
  }
}

import com.hamoid.*;
class VideoRecorder {
  VideoExport videoExport;
  boolean enabled = false;

  VideoRecorder(boolean enabled, VideoExport ve) {
    this.enabled = enabled;
    this.videoExport = ve;
  }

  void start() {
    if (enabled) {
      videoExport.startMovie();
    }
  }

  void frame() {
    if (enabled) {
      videoExport.saveFrame();
    }
  }
}
