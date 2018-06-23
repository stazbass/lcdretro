 import com.hamoid.*;
import shiffman.box2d.*;


final int SCREEN_WIDTH = 1500;
final int SCREEN_HEIGHT = 1000;

VideoRecorder videoRecorder;
ImpulseGrid grid;
GridRenderer render;
ScenePong pongScene;


// ------------
void setup() {
  size(1024, 768, P3D);
  smooth();
  //fullScreen();
  background(0);
  stroke(220, 150, 220);
  fill(250, 10, 250);
  rectMode(CENTER);
  frameRate(50);
  //strokeWeight(1);
  strokeWeight(1.0);
  videoRecorder = new VideoRecorder(ConfigSource.VIDEO_RECORDING_ENABLED, new VideoExport(this, "interactive.mp4"));
  videoRecorder.start();
  grid = new ImpulseGrid(width/ConfigSource.CELL_SIZE, height/ConfigSource.CELL_SIZE, ConfigSource.CELL_SIZE, ConfigSource.CELL_SIZE, ConfigSource.CELL_SIZE/2, ConfigSource.CELL_SIZE/2);
  println("Grid size: " + grid.width + " : " + grid.height);
  render = new GridRenderer(grid);
  pongScene = new ScenePong(render);
}

void draw() {
  clear();

  drawAll();
  updateAll(1.0/450.0);
  videoRecorder.frame();
}

void drawAll() {
  pongScene.draw();
  grid.draw();
}

void updateAll(float delta) {
  pongScene.update(delta);
  grid.update(delta);
}

void keyPressed() {
  if (key == 'q') {
    exit();
  }
  if (key == 'a') {
  }
  if (key == 'c') {
  }
}