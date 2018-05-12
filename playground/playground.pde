int screenWidth = 640;
int screenHeight = 480;
int cellWidth = 10;
int cellHeight = 10;
int gridWidth = screenWidth / cellWidth;
int gridHeight = screenHeight / cellHeight;

ImpulseGrid grid = new ImpulseGrid(640/10, 480/10, 5, 5);

void setup(){
  size(640, 480);
  stroke(100, 100);
  fill(200);
  rectMode(CENTER);
  background(100);
}

PVector pos = new PVector(320, 240);
PVector dir = new PVector(50*random(0, 1), 50*random(0, 1));

long lastFrame = millis();

float lastMouseX = mouseX;

void draw(){
  clear();
  
  long frame = millis();
  float delta = (frame - lastFrame)/1000.0;
  lastFrame = frame;
  pos.x += dir.x*delta;
  pos.y += dir.y*delta;
  if(pos.x > 63){
    pos.x = 63;
    dir.x = -dir.x;
  }
  if(pos.x < 0){
    pos.x = 0;
    dir.x = -dir.x;
  }
  if(pos.y > 47){
    pos.y = 47;
    dir.y = -dir.y;
  }
  if(pos.y < 0){
    pos.y = 0;
    dir.y = -dir.y;
  }
  grid.getCell((int)pos.x, (int)pos.y).applyImpulse(1.0);
  grid.getCell((int)mouseX/10, (int)mouseY/10).applyImpulse(1.0);
  grid.getCell((int)mouseX/10, (int)47).applyImpulse(1.0);
  grid.getCell((int)mouseX/10+1, (int)47).applyImpulse(1.0);
  grid.getCell((int)mouseX/10-1, (int)47).applyImpulse(1.0);
  grid.getCell((int)mouseX/10+2, (int)47).applyImpulse(1.0);
  grid.getCell((int)mouseX/10-2, (int)47).applyImpulse(1.0);
  grid.draw();
  grid.update(delta);
}
