import com.hamoid.*;

final int screenW = 1920;
final int screenH = 1200;
int cellWidth = 13;
int cellHeight = 13;
int gridWidth = screenW / cellWidth;
int gridHeight = screenH / cellHeight;

long lastFrame = millis();
float lastMouseX = mouseX;
ImpulseGrid grid = new ImpulseGrid(gridWidth, gridHeight, cellWidth, cellHeight, 0, 0);
GridRenderer render = new GridRenderer(grid);
Bitka bitka = new Bitka(grid);
VideoExport videoExport;

// ------------
void setup() {
  //size(screenW, screenH);
  fullScreen();
  stroke(200, 200, 200);
  fill(70);
  rectMode(CENTER);
  background(100);
  frameRate(100);
}

void draw() {
  clear();

  long frame = millis();
  float delta = (frame - lastFrame)/1000.0;
  lastFrame = frame;
  
  drawAll();
  updateAll(delta);
}

void drawAll(){
  render.point(10,10);
  grid.draw();
}

void updateAll(float delta){
  grid.update(delta);  
}

void processExit() {
  exit();
}

void keyPressed() {
  if (key == 'q') {
    processExit();
  }
}