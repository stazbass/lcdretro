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
  fullScreen(P3D);
  background(0);
  stroke(220, 150, 220);
  fill(250, 10, 250);
  rectMode(CENTER);
  frameRate(50);
  strokeWeight(1.0);
  
  videoRecorder = new VideoRecorder(ConfigSource.VIDEO_RECORDING_ENABLED, new VideoExport(this, "interactive.mp4"));
  videoRecorder.start();
  grid = new ImpulseGrid(width/ConfigSource.CELL_SIZE, height/ConfigSource.CELL_SIZE, ConfigSource.CELL_SIZE, ConfigSource.CELL_SIZE, ConfigSource.CELL_SIZE/2, ConfigSource.CELL_SIZE/2);
  render = new GridRenderer(grid);
  pongScene = new ScenePong(render);
  println("Grid size: " + grid.width + " : " + grid.height);
}

void draw() {
  clear();

  drawAll();
  updateAll(1.0/100.0);
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
}