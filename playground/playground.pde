int screenW = 1024;
int screenH = 768;
int cellWidth = 10;
int cellHeight = 10;
int gridWidth = screenW / cellWidth;
int gridHeight = screenH / cellHeight;

ImpulseGrid grid = new ImpulseGrid(gridWidth, gridHeight, 5, 5);
Bitka bitka = new Bitka(grid);

void setup(){
  size(1024, 768);
  stroke(100, 100);
  fill(200);
  rectMode(CENTER);
  background(100);
}

PVector pos = new PVector(320, 240);
float speed = 350;
PVector dir = new PVector(speed*random(0, 1), speed*random(0, 1));

long lastFrame = millis();

float lastMouseX = mouseX;

void draw(){
  clear();
  
  long frame = millis();
  float delta = (frame - lastFrame)/1000.0;
  lastFrame = frame;
  pos.x += dir.x*delta;
  pos.y += dir.y*delta;
  if(pos.x > screenW){
    pos.x = screenW;
    dir.x = -dir.x;
  }
  if(pos.x < 0){
    pos.x = 0;
    dir.x = -dir.x;
  }
  if(pos.y > screenH){
    pos.y = screenH;
    dir.y = -dir.y;
  }
  if(pos.y < 0){
    pos.y = 0;
    dir.y = -dir.y;
  }
  
  grid.getCellAt((int)pos.x, (int)pos.y).applyImpulse(1.0);
  grid.getCellAt(mouseX, mouseY).applyImpulse(0.2);
  

  grid.draw();
  grid.update(delta);
  
  bitka.draw();
  bitka.update(delta);
}