import com.hamoid.*;
import shiffman.box2d.*;


final int SCREEN_WIDTH = 1500;
final int SCREEN_HEIGHT = 1000;

VideoRecorder videoRecorder;
Grid grid;
GridRenderer render;
Scenes scenes;
HashMap<Character, Boolean> keys = new HashMap();
PVector mouseSmooth = new PVector();

boolean isKeyPressed(char key){
  return keys.get(key) != null && keys.get(key) == true;
}

// ------------
void setup() {
  //fullScreen(P3D);
  size(1000, 1000, P3D);
  background(0);
  stroke(220, 200, 220);
  fill(250, 10, 250);
  rectMode(CENTER);
  imageMode(CENTER);

  frameRate(100);
  mouseSmooth.x = mouseX;
  mouseSmooth.y = mouseY;
  
  videoRecorder = new VideoRecorder(Config.RECORD_VIDEO, new VideoExport(this, "interactive.mp4"));
  videoRecorder.start();
  grid = new Grid(width/Config.CELL_SIZE, height/Config.CELL_SIZE, Config.CELL_SIZE, Config.CELL_SIZE, Config.CELL_SIZE/2, Config.CELL_SIZE/2);
  render = new GridRenderer(grid);
  scenes = new Scenes();
}

void draw() {
  clear();
  float delta = (1.0/frameRate)/2.0;
  
  drawAll();
  updateAll(delta);
}

void drawAll() {
  scenes.draw();
  grid.draw();
}

void updateAll(float delta) {
  grid.update(delta);
  scenes.update(delta);
  videoRecorder.frame();
}

void keyPressed() {
  keys.put(key, true);
  
  if (key == 'q') {
    exit();
  }
}

void keyReleased(){
  keys.put(key, false);
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