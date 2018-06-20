import com.hamoid.*;
import shiffman.box2d.*;


final boolean enabled = true;
final int SCREEN_WIDTH = 1500;
final int SCREEN_HEIGHT = 1000;
final int CELL_WIDTH = 15;
final int CELL_HEIGHT = CELL_WIDTH;

final int MAX_LINES = 0;


VideoRecorder ve;
ImpulseGrid grid;
GridRenderer render;
ArrayList<Ball> balls = new ArrayList<Ball>(1000);
ArrayList<MovingLine> lines = new ArrayList<MovingLine>(1000);


// ------------
void setup() {
  size(1024, 768);
  smooth();
  fullScreen();
  background(0);
  stroke(210);
  fill(100);
  rectMode(CENTER);
  frameRate(50);
  strokeWeight(1);
  ve = new VideoRecorder(enabled, new VideoExport(this, "interactive.mp4"));
  ve.start();
  grid = new ImpulseGrid(width/CELL_WIDTH, height/CELL_HEIGHT, CELL_WIDTH, CELL_HEIGHT, CELL_WIDTH/2, CELL_HEIGHT/2);
  println("Grid size: " + grid.width + " : " + grid.height);
  render = new GridRenderer(grid);
  lines.add(new MovingLine(grid.width-1, grid.height-1, render));
}

void draw() {
  clear();
  
  drawAll();
  updateAll(1.0/50.0);
  if(frameCount%5 == 0 && lines.size() < 10){
      lines.add(new MovingLine(grid.width-1, grid.height-1, render));
  }
  ve.frame();
}

void drawAll(){
  for(MovingLine line : lines){
    line.draw();
  }
  grid.draw();
}

void updateAll(float delta){
  for(MovingLine line : lines){
    line.update(delta);
  }
  grid.update(delta);  
}

void keyPressed() {
  if (key == 'q') {
      exit();
  }
  if(key == 'a'){

  }
  if(key == 'c'){
  }
}